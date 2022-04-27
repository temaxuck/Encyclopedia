from encyclopedia import db, login_manager
from encyclopedia.math_module import kron_delta, custom_sqrt, OPERATIONS

import math
import sympy as sp
import re
from copy import deepcopy
from flask_login import UserMixin
# from sqlathanor import declarative_base, Column, relationship, AttributeConfiguration
# from jieba.analyse import ChineseAnalyzer
import json

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Many to many relation (Pyramid object being linked to another Pyramid object)
relations = db.Table(
    'relations',                                               
    db.Column('linked_pyramid_id', db.Integer, db.ForeignKey('pyramid.id')), # another pyramid, linked to _self_   
    db.Column('relatedto_pyramid_id', db.Integer, db.ForeignKey('pyramid.id')) # another pyramid, _self_ pyramid is related to 
)

class User(db.Model, UserMixin):
    __tablename__ = 'user'
    __searchable__ = ['username']
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

    def toJSON(self):
        return json.dumps({
            'username': self.username,
            'profile_image': self.profile_imagefile,
            })
    
    def add_pyramid(self, pyramid):
        self.posts.append(pyramid)
        pyramid.user_id = self.id
    
class Pyramid(db.Model):
    __tablename__ = 'pyramid'
    __searchable__ = ['sequence_number']
    
    id = db.Column(db.Integer, primary_key=True)
    sequence_number = db.Column(db.Integer, unique=True, nullable=False)
    generating_function = db.relationship("GeneratingFunction", backref="pyramid", lazy=True)
    explicit_formula = db.relationship("ExplicitFormula", backref="pyramid", lazy=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=True)
    relations = db.relationship('Pyramid', secondary = relations, primaryjoin=(relations.c.linked_pyramid_id == id),
                                secondaryjoin=(relations.c.relatedto_pyramid_id == id),
                                backref=db.backref('linked', lazy='dynamic'), lazy='dynamic')
    __special_hashed_value__ = db.Column(db.String(120))

    gf_dict = {} # needed to evaluate generating_function
    main_gf = None # needed to evaluate generating_function 

    def __init__(self, sequence_number: int):
        self.sequence_number = sequence_number
    
    def __repr__(self):
        return f'Pyramid({self.id}, {self.sequence_number}, {self.generating_function}, {self.explicit_formula})'
    
    def toJSON(self):
        return json.dumps({
            'id': self.id,
            'sequence_number': self.sequence_number,
            'generating_function': self.gf_latex,
            'author': json.loads(self.author.toJSON())
        })
    # def as_dict(self):
    #     return {c.name: getattr(self, c.name) for c in self.__table__.columns}

    # Relations methods
    def isLinked(self, pyramid):
        return True if self.relations.filter_by(sequence_number=pyramid.sequence_number).count() > 0 else False

    def add_relation(self, pyramid):
        if not self.isLinked(pyramid) and not pyramid.isLinked(self):
            self.relations.append(pyramid)
            pyramid.relations.append(self)
    
    def delete_relation(self, pyramid):
        if self.isLinked(pyramid) and pyramid.isLinked(self):
            self.relations.remove(pyramid)
            pyramid.relations.remove(self)

    
    def __get_relations_str__(self):
        return [relation.sequence_number for relation in self.relations ]
    
    def get_relations_as_str(self):
        s = ''

        for loopid, relation in enumerate(self.relations):
            s += str(relation.sequence_number)
            if loopid != len(self.relations.all()) - 1:
                s += ', '
        
        return s

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
        
        self.main_gf = self.get_main_gf()

        if not self.main_gf:
            self.main_gf = self.generating_function[0]
    
    def evaluate_certain_gf(self, function_name:str, values:dict[str:float], sqrt=None):
        values['__builtins__'] = None
        
        if sqrt:
            OPERATIONS['math']['sqrt'] = sqrt
        
        if (self.gf_dict[function_name].other_func_calls == 0):
            return eval(self.gf_dict[function_name].__expr__, values, OPERATIONS['math'])
        
        other_funcs = deepcopy(self.gf_dict[function_name].other_func)
        to_be_evaluated = self.gf_dict[function_name].__expr__
        
        for i in range(len(other_funcs)):
            other_funcs[i] = self.evaluate_certain_gf(other_funcs[i], values)
            to_be_evaluated = re.sub("_TBR_", f"({str(other_funcs[i])})", to_be_evaluated, count=1)
        print(OPERATIONS['math'])
        return eval(to_be_evaluated, values, OPERATIONS['math'])

    def evaluate_gf_at(self, *args):
        if not self.main_gf or not self.gf_dict:
            self.init_gf_evaluation()
            
        try:
            return self.evaluate_certain_gf(self.main_gf.function_name, dict(zip(self.main_gf.__get_variables_str__(), args)))
        except ValueError:
            return self.evaluate_certain_gf(self.main_gf.function_name, dict(zip(self.main_gf.__get_variables_str__(), args)), sqrt={'sqrt': custom_sqrt})
    
    def get_main_gf(self):
        for formula in self.generating_function:
            if formula.isMain:
                return formula
        return None

    @property
    def gf_latex(self):
        latexrepr = ''

        for (loop, formula) in enumerate(self.generating_function):
            latexrepr += r' $$' + formula.get_latex() + r'$$ '

        return latexrepr

    # Explicit formula methods
    def add_explicit_formula(self, variables, expression, limitation=''):
        formula = ExplicitFormula(variables, expression, limitation)
        self.explicit_formula.append(formula)
        formula.pyramid_id = self.id
    
    def evaluate_ef_at(self, *args):
        try:
            values = dict(zip(self.explicit_formula[0].__get_variables_str__(), args))
            answer = None
            for formula in self.explicit_formula:
                formula.init_f_evaluation()

                if not formula.limitation:
                    answer = eval(formula.expression, values, OPERATIONS['combinatorics'])
                    try: answer = int(answer)
                    except: ...
                    return answer

                if eval(formula.limitation_to_eval, values):
                    answer = eval(formula.expression, values, OPERATIONS['combinatorics'])
                    try: answer = int(answer)
                    except: ...
                    return answer
            
            return answer
        except:
            return None
    
    @property
    def ef_latex(self):
        latexrepr = f'$${self.explicit_formula[0].function_name}_{{{self.sequence_number}}}\
                      ({self.explicit_formula[0].get_variables_as_str()}) ='
        if len(self.explicit_formula) > 1:
            latexrepr += r'\begin{cases}' 

        for loopid, formula in enumerate(self.explicit_formula):
            latexrepr += formula.get_latex()
            if formula.limitation:
                latexrepr +=  f'&\\text{{if {formula.limitation}}} '
            if loopid != len(self.explicit_formula) - 1:
                latexrepr += r',\ \\'

        if len(self.explicit_formula) > 1:
            latexrepr += r' \end{cases} '

        latexrepr += '$$'

        return latexrepr

    def get_data_by_ef(self, n, m, k):
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


        try:
            a = self.evaluate_gf_at(*gf_point)
        except ValueError:
            a = 'Undefined'
        
        try:
            b = self.evaluate_ef_at(*ef_point)
        except ValueError:
            b = 'Undefined'

        s = f'{a}_{b}'
        self.__special_hashed_value__ = hashlib.sha256(s.encode()).hexdigest()

class Formula(db.Model):
    __tablename__ = 'formula'
    __searchable__ = 'expression'
    
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
    
    def get_latex(self): # Abstract method
        ...

    def change_formula(self, *args): # Abstract method
        ...
        
    
        

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
    
    def __init__(self, funciton_name: str, variables: str, expression: str, main: bool = False):
        super().__init__(funciton_name, variables, expression)
        self.isMain = main


    def get_latex(self):
        latexrepr = ''

        try:
            latexrepr = sp.latex(sp.sympify(self.expression))
        except:
            latexrepr = f'{self.expression}'+ r'\\ \text{[Error occured, during parsing the expression]}'
        function_declaration = self.function_name
        function_declaration += '_{' + str(self.pyramid.sequence_number) + '}' if self.isMain else ''

        variables_declaration = '('
        for var in self.variables:
            variables_declaration += var.variable_name + ', '
        variables_declaration = variables_declaration[:-2]
        variables_declaration += ')'

        return function_declaration + variables_declaration + ' = ' + latexrepr
    
    def init_f_evaluation(self):
        self.other_func_calls = 0
        other_func = []
        for i in self.expression:
            if ord(i) in range(ord("A"), ord("Z") + 1):
                self.other_func_calls += 1
                other_func.append(i)
        self.__expr__ = re.sub('\^','**', self.expression) # people often use caret to do exponential math, but python should interpret it as ** operator 
        self.__expr__ = re.sub('[A-Z]?\((\w|, )*\)','_TBR_', self.__expr__) # _TBR_ is being replaced later 
        self.other_func = other_func # other functions in chronological order

    def change_formula(self, function_name=None, variables=None, expression=None, main=None):
        self.function_name = function_name if not function_name==None else self.function_name
        self.expression = expression if not expression==None else self.expression
        self.isMain = main if not main==None else self.isMain
        if variables != self.get_variables_as_str() and variables != None:
            used_vars = Variable.query.filter_by(formula_id = self.id)
            used_vars.delete(synchronize_session=False)
            for var in variables.split(','):
                var = var.replace(' ', '')
                var = Variable(var, self.id)
                self.variables.append(var)

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
        
        for key, value in OPERATIONS['equal'].items(): 
            self.limitation_to_eval = re.sub(fr'([^=]){key}([^=])', fr'\1{value}\2', self.limitation_to_eval)

        for key, value in OPERATIONS['separators'].items(): 
            self.limitation_to_eval = re.sub(key, value, self.limitation_to_eval)

        for key, value in OPERATIONS['parity'].items():
            key.encode('unicode_escape')
            value.encode('unicode_escape')
            self.limitation_to_eval = re.sub(r'\b'+key, value, self.limitation_to_eval)

    def get_latex(self):
        try:
            latexrepr = sp.latex(sp.sympify(self.expression))
        except: #sympy.core.sympify.SympifyError
            latexrepr = self.expression
        return latexrepr

    def change_formula(self, variables=None, expression=None, limitation=None):
        self.expression = expression if not expression==None else self.expression
        self.limitation = limitation if not expression==None else self.limitation
        if variables != self.get_variables_as_str() and variables != None:
            used_vars = Variable.query.filter_by(formula_id = self.id)
            used_vars.delete(synchronize_session=False)
            for var in variables.split(','):
                var = var.replace(' ', '')
                var = Variable(var, self.id)
                self.variables.append(var)

    __mapper_args__ = {
        'polymorphic_identity': 'explicitformula',
    }
    
# from encyclopedia import search
# search.create_index(Pyramid)
