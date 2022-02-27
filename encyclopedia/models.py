from encyclopedia import db, login_manager
from flask_login import UserMixin
from encyclopedia.math_module import kron_delta

import sympy as sp
import re
from copy import deepcopy
from math import sqrt
# from encyclopedia.math_module import delta

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Many to many relation (Pyramid object being linked to another Pyramid object)
relations = db.Table('relations',                                               
    db.Column('linked_pyramid_id', db.Integer, db.ForeignKey('pyramid.id')), # another pyramid, linked to _self_   
    db.Column('relatedto_pyramid_id', db.Integer, db.ForeignKey('pyramid.id')) # another pyramid, _self_ pyramid is related to 
)


class User(db.Model, UserMixin):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(30), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    profile_imagefile = db.Column(db.String(20), nullable=False, default='default.png')
    password = db.Column(db.String(60), nullable=False)
    posts = db.relationship('Pyramid', backref='author', lazy=True)

    moderator = db.Column(db.Boolean, default=False)

    def __init__(self, username, email, password, moderator=False):
        self.username = username
        self.email = email
        self.password = password
        self.moderator = moderator

    def __repr__(self):
        return f'User("{self.username}", "{self.email}", "{self.profile_imagefile}", moderator={self.moderator})'

    def add_pyramid(self, pyramid):
        self.posts.append(pyramid)
        pyramid.user_id = self.id
    

class Pyramid(db.Model):
    __tablename__ = 'pyramid'
    id = db.Column(db.Integer, primary_key=True)
    sequence_number = db.Column(db.Integer, unique=True, nullable=False)
    generating_function = db.relationship("GeneratingFunction", backref="pyramid", lazy=True)
    explicit_formula = db.relationship("ExplicitFormula", backref="pyramid", lazy=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=True)
    relations = db.relationship('Pyramid', secondary = relations, primaryjoin=(relations.c.linked_pyramid_id == id),
        secondaryjoin=(relations.c.relatedto_pyramid_id == id),
    backref=db.backref('linked', lazy='dynamic'), lazy='dynamic')
    __special_hashed_value__ = db.Column(db.String(120))
    # datalist = 

    gf_dict = {} # needed to evaluate generating_function
    main_gf = None # needed to evaluate generating_function 

    def __init__(self, sequence_number):
        self.sequence_number = sequence_number
    
    def __repr__(self):
        return f'Pyramid({self.id}, {self.sequence_number}, {self.generating_function}, {self.explicit_formula})'

    # Linking pyramids with each other:
    def isLinked(self, pyramid):
        return True if self.relations.filter_by(sequence_number=pyramid.sequence_number).count() > 0 else False

    def add_relation(self, pyramid):
        if not self.isLinked(pyramid) and not pyramid.isLinked(self):
            self.relations.append(pyramid)
            pyramid.relations.append(self)
    
    # Generating function methods
    def add_generating_function(self, funciton_name, variables, expression, isMain):
        formula = GeneratingFunction(funciton_name, variables, expression, isMain)
        self.generating_function.append(formula)
        formula.pyramid_id = self.id
    
    def init_gf_evaluation(self):
        for formula in self.generating_function:
            formula.init_f_evaluation()
            if not self.gf_dict.get(formula.function_name):
                self.gf_dict.update({formula.function_name : formula})
            else:
                self.gf_dict[formula.function_name] = formula
            if formula.isMain:
                self.main_gf = formula

    def evaluate_certain_gf(self, function_name, values:dict[str:float]):
        values['__builtins__'] = None
        if (self.gf_dict[function_name].other_func_calls == 0):
            return eval(self.gf_dict[function_name].expression, values, {'sqrt': sqrt})
        
        other_funcs = deepcopy(self.gf_dict[function_name].other_func)
        to_be_evaluated = self.gf_dict[function_name].__expr__
        
        for i in range(len(other_funcs)):
            other_funcs[i] = self.evaluate_certain_gf(other_funcs[i], values)
            to_be_evaluated = re.sub("_TBR_", f"({str(other_funcs[i])})", to_be_evaluated, count=1)
        
        return eval(to_be_evaluated, values, {'sqrt': sqrt})

    def evaluate_gf_at(self, *args):
        if self.main_gf is None or not gf_dict:
            self.init_gf_evaluation()
        return self.evaluate_certain_gf(self.main_gf.function_name, dict(zip(self.main_gf.__get_variables_str__(), args)))
    
    def get_main_gf(self):
        for formula in self.generating_function:
            if formula.isMain:
                return formula
        return None

    def get_gf_latex(self):
        latexrepr = []
        for formula in self.generating_function:
            latexrepr.append(formula.get_latex)

    # Explicit formula methods
    def add_explicit_formula(self, variables, expression, limitation=''):
        formula = ExplicitFormula(variables, expression, limitation)
        self.explicit_formula.append(formula)
        formula.pyramid_id = self.id
    
    def evaluate_ef_at(self, *args):
        values = dict(zip(self.explicit_formula[0].__get_variables_str__(), args))
        answer = None
        for formula in self.explicit_formula:
            formula.init_f_evaluation()

            if not formula.limitation:
                answer = eval(formula.expression, values, {'binomial': sp.binomial, 'delta': kron_delta})
                continue

            if eval(formula.limitation_to_eval, values):
                answer = eval(formula.expression, values, {'binomial': sp.binomial, 'delta': kron_delta})
        
        return answer
    
    def get_ef_latex(self):
        latexrepr = f'{self.explicit_formula[0].function_name}_{{{self.sequence_number}}} \
({self.explicit_formula[0].get_variables_as_str()}) = \\begin{{cases}}' 

        for loopid, formula in enumerate(self.explicit_formula):
            latexrepr += formula.get_latex()
            if formula.limitation:
                latexrepr +=  f'&\\text{{if {formula.limitation}}} '
            if loopid != len(self.explicit_formula) - 1:
                latexrepr += ',\\\\'
        latexrepr += ' \\end{cases}'

        return latexrepr

    def get_data(self, n, m, k):
        data = []
        for i in range(n):
            for j in range(m):
                data.append(self.evaluate_ef_at(i, j, k))
        return data

    # Special hashed value methods
    def init_special_value(self):
        import hashlib
        gf_point = [] 
        ef_point = []
        
        for i in range(len(self.get_main_gf().variables)):
            gf_point.append(30 + i + 1)
        for i in range(len(self.explicit_formula[0].variables)):
            ef_point.append(30 + i + 1)

        a = self.evaluate_gf_at(*gf_point)
        b = self.evaluate_ef_at(*ef_point)
        # print(a, b)
        s = f'{a}_{b}'
        self.__special_hashed_value__ = hashlib.sha256(s.encode()).hexdigest()

class Formula(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    function_name = db.Column(db.String(20), nullable=False)
    variables = db.relationship('Variable', backref='formula', lazy=True) 
    expression = db.Column(db.String(120), nullable=False)
    pyramid_id = db.Column(db.Integer, db.ForeignKey('pyramid.id'))


    type = db.Column(db.String(50))

    __mapper_args__ = {
        'polymorphic_identity': 'formula',
        'polymorphic_on': type
    }

    def __init__(self, funciton_name, variables, expression):
        self.function_name = funciton_name
        self.expression = expression
        for var in variables.split(','):
            var = var.replace(' ', '')
            var = Variable(var, self.id)
            self.variables.append(var)

    def __repr__(self):
        return f'Formula("{self.function_name}", {self.variables}, "{self.expression}", {self.pyramid_id})'

    
    def __get_variables_str__(self):
        temp = []
        for var in self.variables: temp.append(str(var))
        return temp

    def get_variables_as_str(self):
        s = ''
        for loopid, var in enumerate(self.variables):
            s += var.variable_name
            if loopid != len(self.variables) - 1:
                s += ', '
        return s


class Variable(db.Model):
    __tablename__ = 'variable'
    id = db.Column(db.Integer, primary_key=True)
    variable_name = db.Column(db.String(1), nullable=False)
    formula_id = db.Column(db.Integer, db.ForeignKey('formula.id'), nullable=False)

    def isVariable(self, variable_name, formula_id):
        return Variable.query.filter_by(variable_name=variable_name, formula_id=formula_id).count() > 0

    def __init__(self, variable_name, formula_id):
        if not self.isVariable(variable_name, formula_id):
            self.variable_name = variable_name
            self.formula_id = formula_id
    
    def __repr__(self):
        return f"{self.variable_name}"


class GeneratingFunction(Formula):
    __tablename__ = 'generatingfunction'
    id = db.Column(db.Integer, db.ForeignKey('formula.id'), primary_key=True)
    isMain = db.Column(db.Boolean, nullable=False)
    other_func_calls = 0
    other_func = []
    __expr__ = ""
    
    def __init__(self, funciton_name, variables, expression, main=False):
        super().__init__(funciton_name, variables, expression)
        self.isMain = main


    def get_latex(self):
        latexexpr = sp.latex(sp.sympify(self.expression))
        function_declaration = self.function_name
        function_declaration += '_{' + str(self.pyramid.sequence_number) + '}' if self.isMain else ''

        variables_declaration = '('
        for var in self.variables:
            variables_declaration += var.variable_name + ', '
        variables_declaration = variables_declaration[:-2]
        variables_declaration += ')'


        return function_declaration + variables_declaration + ' = ' + latexexpr
    
    def init_f_evaluation(self):
        self.other_func_calls = 0
        other_func = []
        for i in self.expression:
            if ord(i) in range(ord("A"), ord("Z") + 1):
                self.other_func_calls += 1
                other_func.append(i)
        self.__expr__ = re.sub('[A-Z]?\((\w|, )*\)','_TBR_', self.expression) # _TBR_ is being replaced later 
        self.other_func = other_func # other functions in chronological order

    __mapper_args__ = {
        'polymorphic_identity': 'generatingfunction',
    }


class ExplicitFormula(Formula):
    __tablename__ = 'explicitformula'
    id = db.Column(db.Integer, db.ForeignKey('formula.id'), primary_key=True)
    limitation = db.Column(db.String(100))
    limitation_to_eval = ""

    def __init__(self, variables, expression, limitation=""):
        super().__init__('T', variables, expression)
        self.limitation = limitation

    def init_f_evaluation(self):
        self.limitation_to_eval = self.limitation
        self.limitation_to_eval = self.limitation_to_eval.replace(',', ' and ')
        self.limitation_to_eval = self.limitation_to_eval.replace('=', '==')

    def get_latex(self):
        latexexpr = sp.latex(sp.sympify(self.expression))
        
        return latexexpr

    __mapper_args__ = {
        'polymorphic_identity': 'generatingfunction',
    }

    __mapper_args__ = {
        'polymorphic_identity': 'explicitformula',
    }