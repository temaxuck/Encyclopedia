import json
import math
import re
from copy import deepcopy

import sympy as sp
from flask import current_app
from flask_login import UserMixin
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.orm import Session

from encyclopedia import db, hasher, login_manager
from encyclopedia.math_module import OPERATIONS, custom_sqrt


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


# Many to many relation (Pyramid object is being linked to another Pyramid object)
# linked_pyramid_id -> relatedto_pyramid_id
relations = db.Table(
    "relations",
    db.Column("tag", db.String(30), nullable=True),  # original pyramid
    db.Column(
        "linked_pyramid_id", db.Integer, db.ForeignKey("pyramid.id")
    ),  # original pyramid
    db.Column(
        "relatedto_pyramid_id", db.Integer, db.ForeignKey("pyramid.id")
    ),  # pyramid, to which original one is linked
)


class User(db.Model, UserMixin):
    __tablename__ = "user"
    __searchable__ = ["username"]
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(30), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    profile_imagefile = db.Column(db.String(20), nullable=False, default="default.png")
    password = db.Column(db.String(60), nullable=False)
    posts = db.relationship("Pyramid", backref="author", lazy=True)

    moderator = db.Column(db.Boolean, default=False)

    def __init__(self, username, email, password, moderator=False):
        self.username = username
        self.email = email
        self.password = hasher.generate_password_hash(password).decode("utf-8")
        self.moderator = moderator

    def __repr__(self):
        return f'User("{self.username}", "{self.email}", "{self.profile_imagefile}", moderator={self.moderator})'

    def toJSON(self):
        return json.dumps(
            {
                "username": self.username,
                "profile_image": self.profile_imagefile,
            }
        )

    def add_pyramid(self, pyramid):
        self.posts.append(pyramid)
        pyramid.user_id = self.id


class Pyramid(db.Model):
    __tablename__ = "pyramid"
    __searchable__ = ["sequence_number"]

    id = db.Column(db.Integer, primary_key=True)
    sequence_number = db.Column(db.Integer, unique=True, nullable=False)
    generating_function = db.relationship(
        "GeneratingFunction", backref="pyramid", lazy=True, cascade="all,delete"
    )
    explicit_formula = db.relationship(
        "ExplicitFormula", backref="pyramid", lazy=True, cascade="all,delete"
    )

    # Array of strings, represents the data table, you can get calling get_data_by_ef(7, 7, 1)
    data = db.Column(ARRAY(db.String), nullable=True)

    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=True)
    relations = db.relationship(
        "Pyramid",
        secondary=relations,
        primaryjoin=(relations.c.linked_pyramid_id == id),
        secondaryjoin=(relations.c.relatedto_pyramid_id == id),
        backref=db.backref("linked", lazy="dynamic"),
        lazy="dynamic",
    )
    __special_hashed_value__ = db.Column(db.String(120))

    gf_dict = {}  # needed to evaluate generating_function
    main_gf = None  # needed to evaluate generating_function

    def __init__(self, sequence_number: int):
        self.sequence_number = sequence_number

    def __repr__(self):
        return f"Pyramid({self.id}, {self.sequence_number}, {self.generating_function}, {self.explicit_formula})"

    def json(self):
        def convert_to_int(value):
            try:
                return int(float(value))
            except:
                return 0

        def data_to_int():
            return list(map(lambda x: convert_to_int(x), self.data))

        return json.dumps(
            {
                "id": self.id,
                "sequence_number": self.sequence_number,
                "generating_function": [
                    json.loads(gf.json()) for gf in self.generating_function
                ],
                "explicit_formula": [
                    json.loads(ef.json()) for ef in self.explicit_formula
                ],
                "data": data_to_int(),
                "statuscode": self.status[0],
                # "latex_representation": self.latex,
                "gf_latex": self.gf_latex.replace("$", ""),
                "ef_latex": self.ef_latex.replace("$", ""),
                "author": json.loads(self.author.toJSON()) if self.author else None,
            }
        )

    def toJSON(self):
        # data needed for search results only
        # use json() to get whole data about pyramid
        return json.dumps(
            {
                "id": self.id,
                "sequence_number": self.sequence_number,
                "generating_function": self.gf_latex,
                "statuscode": self.status[0],
                "author": json.loads(self.author.toJSON()) if self.author else None,
            }
        )

    @property
    def status(self):
        # statuscode 0: OK
        # statuscode 1: has missed instances

        missed = []
        statuscode = 0

        if not self.generating_function:
            missed.append("generating_function")

        if not self.explicit_formula:
            missed.append("explicit_formula")

        if not self.user_id:
            missed.append("user_id")

        if missed:
            statuscode = 1

        return statuscode, missed

    # Relations methods
    def isLinked(self, pyramid):
        return (
            True
            if self.relations.filter_by(sequence_number=pyramid.sequence_number).count()
            > 0
            else False
        )

    def add_relation(self, relatedto_pyramid_id, tag):
        from sqlalchemy import and_, update

        with db.engine.connect() as conn:
            pyramid = Pyramid.query.filter_by(id=relatedto_pyramid_id).first()

            if not self.isLinked(pyramid):
                self.relations.append(pyramid)

                db.session.commit()

                conn.execute(
                    update(relations)
                    .values({"tag": tag})
                    .where(
                        and_(
                            relations.c.linked_pyramid_id == self.id,
                            relations.c.relatedto_pyramid_id == relatedto_pyramid_id,
                        )
                    )
                )

    def set_existing_relation(self, relatedto_pyramid_id: int, tag: str) -> None:
        from sqlalchemy import and_, update

        db.session.query(relations).filter(
            and_(
                relations.c.linked_pyramid_id == self.id,
                relations.c.relatedto_pyramid_id == relatedto_pyramid_id,
            )
        ).one()

        with db.engine.connect() as conn:
            conn.execute(
                update(relations)
                .values({"tag": tag})
                .where(
                    and_(
                        relations.c.linked_pyramid_id == self.id,
                        relations.c.relatedto_pyramid_id == relatedto_pyramid_id,
                    )
                )
            )

    def delete_relation(self, pyramid):
        from sqlalchemy import and_, or_

        if self.isLinked(pyramid) and pyramid.isLinked(self):
            to_delete = db.session.query(relations).filter(
                and_(
                    relations.c.linked_pyramid_id == self.id,
                    relations.c.relatedto_pyramid_id == pyramid.id,
                ),
            )
            to_delete.delete(synchronize_session=False)
            db.session.commit()

    def delete_all_relations(self):
        from sqlalchemy import and_, or_

        to_delete = db.session.query(relations).filter(
            relations.c.linked_pyramid_id == self.id
        )
        to_delete.delete(synchronize_session=False)
        db.session.commit()

    # Should be rewrote
    def __get_relations_str__(self):
        return [relation.sequence_number for relation in self.relations]

    # Should be rewrote
    def get_relations_as_str(self):
        s = ""

        for loopid, relation in enumerate(self.relations):
            s += str(relation.sequence_number)
            if loopid != len(self.relations.all()) - 1:
                s += ", "

        return s

    def get_relations_as_dict(self):
        return [
            {"relatedto_pyramid": relation[2], "tag": relation[0]}
            for relation in db.session.query(relations)
            .filter(relations.c.linked_pyramid_id == self.id)
            .all()
        ]

    # Get one particular relation with given relatedto_pyramid_id
    def get_relation(self, relatedto_pyramid_id: int):
        for relation in self.get_relations_as_dict():
            if relation.get("relatedto_pyramid") == relatedto_pyramid_id:
                return relation

        return None

    # Generating function methods
    def add_generating_function(
        self, funciton_name: str, variables: str, expression: str, ismain: bool
    ):
        formula = GeneratingFunction(funciton_name, variables, expression, ismain)
        self.generating_function.append(formula)
        formula.pyramid_id = self.id

    def init_gf_evaluation(self):
        for formula in self.generating_function:
            formula.init_f_evaluation()
            if not self.gf_dict.get(formula.function_name):
                self.gf_dict.update({formula.function_name: formula})
            else:
                self.gf_dict[formula.function_name] = formula

        self.main_gf = self.get_main_gf()

        if not self.main_gf:
            self.main_gf = self.generating_function[0]

    def evaluate_certain_gf(
        self, function_name: str, values: dict[str:float], sqrt=None
    ):
        values["__builtins__"] = None

        if sqrt:
            OPERATIONS["math"]["sqrt"] = sqrt["sqrt"]

        if self.gf_dict[function_name].other_func_calls == 0:
            return eval(
                self.gf_dict[function_name].__expr__, values, OPERATIONS["math"]
            )

        other_funcs = deepcopy(self.gf_dict[function_name].other_func)
        to_be_evaluated = self.gf_dict[function_name].__expr__

        for i in range(len(other_funcs)):
            other_funcs[i] = self.evaluate_certain_gf(other_funcs[i], values)
            to_be_evaluated = re.sub(
                "_TBR_", f"({str(other_funcs[i])})", to_be_evaluated, count=1
            )

        return eval(to_be_evaluated, values, OPERATIONS["math"])

    def evaluate_gf_at(self, *args):
        if not self.main_gf or not self.gf_dict:
            self.init_gf_evaluation()

        try:
            return self.evaluate_certain_gf(
                self.main_gf.function_name,
                dict(zip(self.main_gf.__get_variables_str__(), args)),
            )
        except ValueError:
            return self.evaluate_certain_gf(
                self.main_gf.function_name,
                dict(zip(self.main_gf.__get_variables_str__(), args)),
                sqrt={"sqrt": custom_sqrt},
            )

    def get_main_gf(self):
        for formula in self.generating_function:
            if formula.ismain:
                return formula
        return None

    # @property
    # def latex(self):
    #     return self.gf_latex.replace("$", "") + r" \\ " + self.ef_latex.replace("$", "")

    @property
    def gf_latex(self):
        latexrepr = ""

        if not self.generating_function:
            return "None"

        for loop, formula in enumerate(self.generating_function):
            latexrepr += r"$$" + formula.get_latex() + r"$$ "

        return latexrepr

    # Explicit formula methods
    def add_explicit_formula(
        self, variables: str, expression: str, limitation: str = ""
    ):
        formula = ExplicitFormula(variables, expression, limitation)
        self.explicit_formula.append(formula)
        formula.pyramid_id = self.id

    def evaluate_ef_at(self, *args):
        try:
            values = dict(zip(self.explicit_formula[0].__get_variables_str__(), args))
            result = None
            for formula in self.explicit_formula:
                formula.init_f_evaluation()

                if not formula.limitation or eval(formula.limitation_to_eval, values):
                    result = eval(
                        formula.expression, values, OPERATIONS["combinatorics"]
                    )
                    return result

            return result
        except Exception as e:
            return None

    @property
    def ef_latex(self):
        latexrepr = ""
        implicit_formulas = set()

        try:
            ef_repr = f"$${self.explicit_formula[0].function_name}_{{{self.sequence_number}}}({self.explicit_formula[0].get_variables_as_str()}) = "
            if len(self.explicit_formula) > 1:
                ef_repr += r"\begin{cases}"

            for loopid, formula in enumerate(self.explicit_formula):
                implicit_formulas.update(formula.search_for_implicit_formulas())
                ef_repr += formula.get_latex()
                if formula.limitation:
                    ef_repr += f"&\\text{{if {formula.limitation}}} "
                if loopid != len(self.explicit_formula) - 1:
                    ef_repr += r",\ \\"

            if len(self.explicit_formula) > 1:
                ef_repr += r" \end{cases} "

            ef_repr += "$$"

            for implicit_formula in implicit_formulas:
                latexrepr += implicit_formula.latex + r" \\ "

            latexrepr += ef_repr

        except IndexError:
            latexrepr = "None"

        latexrepr = re.sub(r"(\S)\s*<\s*(\S)", r"\1 < \2", latexrepr)
        latexrepr = re.sub(r"(\S)\s*>\s*(\S)", r"\1 > \2", latexrepr)

        return latexrepr

    @property
    def gf_maxima(self):
        try:
            result = ""
            for loopid, formula in enumerate(self.generating_function):
                result = f"{formula.function_name}{self.sequence_number}({formula.get_variables_as_str()}) := {formula.get_maxima()};"
        except:
            result = "Generating function export to Maxima is not supported for this Pyramid yet."
        return result

    @property
    def ef_maxima(self):
        try:
            result = f"{self.explicit_formula[0].function_name}{self.sequence_number}({self.explicit_formula[0].get_variables_as_str()}) := "
            for loopid, formula in enumerate(self.explicit_formula):
                result += formula.get_maxima()
                if loopid != len(self.explicit_formula) - 1:
                    result += " else "
            result += ";"
        except:
            result = "Explicit formula export to Maxima is not supported for this Pyramid yet."
        return result

    def get_data_by_ef(self, n, m, k):
        data = []
        for i in range(n):
            for j in range(m):
                data.append(self.evaluate_ef_at(i, j, k))
        return data

    def get_data_represenation_by_ef(self, n, m, k):
        data = []
        for i in range(n):
            for j in range(m):
                result = self.evaluate_ef_at(i, j, k)
                try:
                    result = str(result).rstrip("0").rstrip(".") if result != 0 else "0"
                except Exception as e:
                    result = None
                data.append(result)
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
        except Exception:
            a = "Undefined"

        try:
            b = self.evaluate_ef_at(*ef_point)
        except Exception:
            b = "Undefined"

        s = f"{a}_{b}"
        self.__special_hashed_value__ = hashlib.sha256(s.encode()).hexdigest()


class Formula(db.Model):
    __tablename__ = "formula"
    __searchable__ = "expression"

    id = db.Column(db.Integer, primary_key=True)
    function_name = db.Column(db.String(20), nullable=False)
    variables = db.relationship(
        "Variable", backref="formula", lazy=True, cascade="all,delete"
    )
    expression = db.Column(db.String(120), nullable=False)
    pyramid_id = db.Column(db.Integer, db.ForeignKey("pyramid.id", ondelete="CASCADE"))

    type = db.Column(db.String(50))

    __mapper_args__ = {"polymorphic_identity": "formula", "polymorphic_on": type}

    def __init__(self, funciton_name, variables, expression):
        self.function_name = funciton_name
        self.expression = expression
        for var in variables.split(","):
            var = var.replace(" ", "")
            var = Variable(var, self.id)
            self.variables.append(var)

    def __repr__(self):
        return f'Formula("{self.function_name}", {self.variables}, "{self.expression}", {self.pyramid_id})'

    def json(self):
        return json.dumps(
            {
                "name": self.function_name,
                "variables": self.get_variables_as_str(),
                "expression": self.expression,
            }
        )

    def __get_variables_str__(self):
        temp = []
        for var in self.variables:
            temp.append(str(var))
        return temp

    def get_variables_as_str(self):
        s = ""
        for loopid, var in enumerate(self.variables):
            s += var.variable_name
            if loopid != len(self.variables) - 1:
                s += ", "
        return s

    def search_for_implicit_formulas(self):
        def get_implicit_formula(d, key):
            if key in d:
                return d[key]
            for k, v in d.items():
                if isinstance(v, dict):
                    result = get_implicit_formula(v, key)
                    if result is not None:
                        try:
                            if result.isImplicit:
                                return result
                        except:
                            return None
            return None

        pattern = r"\b([a-zA-Z_]\w*)\s*\("
        matches = re.findall(pattern, self.expression)

        result = []

        for match in matches:
            if implicit_formula := get_implicit_formula(OPERATIONS, match):
                result.append(implicit_formula)

        return result

    # Abstract method
    def init_f_evaluation(self):
        ...

    # Abstract method
    def get_latex(self):
        ...

    # Abstract method
    def change_formula(self, *args):
        ...


class GeneratingFunction(Formula):
    __tablename__ = "generatingfunction"

    id = db.Column(
        db.Integer, db.ForeignKey("formula.id", ondelete="CASCADE"), primary_key=True
    )
    ismain = db.Column(db.Boolean, nullable=False)
    other_func_calls = 0
    other_func = []
    __expr__ = ""

    def __init__(
        self, funciton_name: str, variables: str, expression: str, main: bool = False
    ):
        super().__init__(funciton_name, variables, expression)
        self.ismain = main

    def json(self):
        jdata = json.loads(super().json())
        jdata.update({"is_main": self.ismain})

        return json.dumps(jdata)

    def get_latex(self):
        latexrepr = ""

        try:
            latexrepr = sp.latex(sp.sympify(self.expression))
        except:
            latexrepr = (
                f"{self.expression}"
                + r"\\ \text{[Error occured, during parsing the expression]}"
            )
        function_declaration = self.function_name
        function_declaration += (
            "_{" + str(self.pyramid.sequence_number) + "}" if self.ismain else ""
        )

        variables_declaration = "("
        for var in self.variables:
            variables_declaration += var.variable_name + ", "
        variables_declaration = variables_declaration[:-2]
        variables_declaration += ")"

        return function_declaration + variables_declaration + " = " + latexrepr

    def get_maxima(self):
        maximarepr = self.expression

        return maximarepr

    def init_f_evaluation(self):
        self.other_func_calls = 0
        other_func = []
        for i in self.expression:
            if ord(i) in range(ord("A"), ord("Z") + 1):
                self.other_func_calls += 1
                other_func.append(i)
        self.__expr__ = re.sub(
            r"\^", "**", self.expression
        )  # people often use caret to do exponential math, but python should interpret it as ** operator
        self.__expr__ = re.sub(
            r"[A-Z]?\((\w|, )*\)", "_TBR_", self.__expr__
        )  # _TBR_ is being replaced later
        self.other_func = other_func  # other functions in chronological order

    def change_formula(
        self, function_name=None, variables=None, expression=None, main=None
    ):
        self.function_name = (
            function_name if not function_name == None else self.function_name
        )
        self.expression = expression if not expression == None else self.expression
        self.ismain = main if not main == None else self.ismain
        if variables != self.get_variables_as_str() and variables != None:
            used_vars = Variable.query.filter_by(formula_id=self.id)
            used_vars.delete(synchronize_session=False)
            for var in variables.split(","):
                var = var.replace(" ", "")
                var = Variable(var, self.id)
                self.variables.append(var)

    __mapper_args__ = {
        "polymorphic_identity": "generatingfunction",
    }


class ExplicitFormula(Formula):
    __tablename__ = "explicitformula"
    id = db.Column(
        db.Integer, db.ForeignKey("formula.id", ondelete="CASCADE"), primary_key=True
    )
    limitation = db.Column(db.String(100))
    limitation_to_eval = ""

    def __init__(self, variables, expression, limitation=""):
        super().__init__("T", variables, expression)
        self.limitation = limitation

    def json(self):
        jdata = json.loads(super().json())
        jdata.update({"limitation": self.limitation})

        return json.dumps(jdata)

    def init_f_evaluation(self):
        self.limitation_to_eval = self.limitation

        for key, value in OPERATIONS["equal"].items():
            self.limitation_to_eval = re.sub(
                rf"([^=]){key}([^=])", rf"\1{value}\2", self.limitation_to_eval
            )

        for key, value in OPERATIONS["separators"].items():
            self.limitation_to_eval = re.sub(key, value, self.limitation_to_eval)

        for key, value in OPERATIONS["parity"].items():
            key.encode("unicode_escape")
            value.encode("unicode_escape")
            p = re.compile(rf"(.+)({key})")
            result = p.search(self.limitation_to_eval)
            if not result:
                continue
            # print(result, "\n", result.groups())
            # print(re.sub(fr'(.+)', r'(\1)', result.group(1)) + result.group(2))
            self.limitation_to_eval = (
                re.sub(rf"(.+)", r"(\1)", result.group(1)) + " " + result.group(2)
            )
            self.limitation_to_eval = re.sub(
                rf"\b{key}\b", value, self.limitation_to_eval
            )

    def get_latex(self):
        try:
            latexrepr = sp.latex(sp.sympify(self.expression))
        except:  # sympy.core.sympify.SympifyError
            latexrepr = self.expression
        return latexrepr

    def get_maxima(self):
        import re

        maximarepr = self.expression
        maximarepr = re.sub("delta", "kron_delta", maximarepr)

        if lim := self.limitation_to_eval:
            # lim = re.sub(r'(.+)', r'(\1)', lim)
            p = re.compile(r"(.*)\s*%\s*([^=]*)\s*[=]+(.*)")
            result = p.search(lim)
            if result:
                lim = rf"mod({result.group(1)}, {result.group(2)}) = {result.group(3)}"
            maximarepr = f"if {lim} then {maximarepr}"

        return maximarepr

    def change_formula(self, variables=None, expression=None, limitation=None):
        self.expression = expression if not expression == None else self.expression
        self.limitation = limitation if not expression == None else self.limitation
        if variables != self.get_variables_as_str() and variables != None:
            used_vars = Variable.query.filter_by(formula_id=self.id)
            used_vars.delete(synchronize_session=False)
            for var in variables.split(","):
                var = var.replace(" ", "")
                var = Variable(var, self.id)
                self.variables.append(var)

    __mapper_args__ = {
        "polymorphic_identity": "explicitformula",
    }


class Variable(db.Model):
    __tablename__ = "variable"
    id = db.Column(db.Integer, primary_key=True)
    variable_name = db.Column(db.String(1), nullable=False)
    formula_id = db.Column(
        db.Integer, db.ForeignKey("formula.id", ondelete="CASCADE"), nullable=False
    )

    def isVariable(self, variable_name, formula_id):
        return (
            Variable.query.filter_by(
                variable_name=variable_name, formula_id=formula_id
            ).count()
            > 0
        )

    def __init__(self, variable_name, formula_id):
        if not self.isVariable(variable_name, formula_id):
            self.variable_name = variable_name
            self.formula_id = formula_id

    def __repr__(self):
        return f"{self.variable_name}"
