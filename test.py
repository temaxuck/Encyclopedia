import sympy as sp
# from sympy.abc import *
# from sympy.utilities.lambdify import implemented_function, lambdify
from sympy.parsing.sympy_parser  import parse_expr
import time
# G = Function('G')
# x, y = symbols('x y')
# V = sympify('(sqrt(x*(4*(G(y))**3 + 27*x)) / (2 * 3**(3/2)) + (G(y)**3)/27 + x/2)**(1/3)', )
# print(latex(V, mul_symbol='dot'))

from encyclopedia.models import User, Pyramid \
    ,Formula, Variable, GeneratingFunction, ExplicitFormula
    
from encyclopedia import db

# db.drop_all()
# User.query.all()[0].moderator = True
# db.session.commit()
# print(User.query.all())
# Formula.__table__.drop(db.engine)
# Variable.__table__.drop(db.engine)
# GeneratingFunction.__table__.drop(db.engine)
# ExplicitFormula.__table__.drop(db.engine)
# db.create_all()

# G = GeneratingFunction("G", 'y', "1 / ((1 - y)**2)", main=False)
# V = GeneratingFunction("V", 'x, y', "(sqrt(x*(4*(G(y))**3 + 27*x)) / (2 * 3**(3/2)) + (G(y)**3)/27 + x/2)**(1/3)", main=False)
# U = GeneratingFunction("U", 'x, y', "(G(y)**2) / (9 * V(x, y)) + G(y) / 3 + V(x, y)", main=True)

# db.session.add(G)
# db.session.add(V)
# db.session.add(U)
# db.session.commit()


# T1 = ExplicitFormula('n, m, k', "1", limitation="m=0, n=0")
# T2 = ExplicitFormula('n, m, k', "2*binomial(2*n-2*k-1,m-1)*k/m*(-1)**(m-1)", limitation="m=0")
# T3 = ExplicitFormula('n, m, k', "(binomial(k-2*n-1,n-1))*(binomial(-6*n+m+2*k-1,m))*k/n", limitation="")

# db.session.add(T1)
# db.session.add(T2)
# db.session.add(T3)
# db.session.commit()

# T1.init_f_evaluation()
# print(T1.limitation_to_eval)
# ExplicitFormula.query.all()[2].limitation = "n > 0"
# db.session.commit()
# pyr420 = Pyramid.query.filter_by(sequence_number=420).all()[0]
# pyr420.add_explicit_formula('n, m, k', "1", "m=0, n=0")
# pyr420.add_explicit_formula('n, m, k', "2*binomial(2*n-2*k-1,m-1)*k/m*(-1)**(m-1)", limitation="m=0")
# pyr420.add_explicit_formula('n, m, k', "(binomial(k-2*n-1,n-1))*(binomial(-6*n+m+2*k-1,m))*k/n", limitation="")
# pyr420.add_generating_function(GeneratingFunction.query.all()[2].function_name, GeneratingFunction.query.all()[2].get_variables_as_str(), GeneratingFunction.query.all()[2].expression, GeneratingFunction.query.all()[2].isMain)
# pyr420.add_generating_function(GeneratingFunction.query.all()[1].function_name, GeneratingFunction.query.all()[1].get_variables_as_str(), GeneratingFunction.query.all()[1].expression, GeneratingFunction.query.all()[1].isMain)
# pyr420.add_generating_function(GeneratingFunction.query.all()[0].function_name, GeneratingFunction.query.all()[0].get_variables_as_str(), GeneratingFunction.query.all()[0].expression, GeneratingFunction.query.all()[0].isMain)
# pyr420.init_special_value()
# print(pyr420.__special_hashed_value__)
# print(pyr420.evaluate_gf_at(10, 10))
# print(ExplicitFormula.query.filter_by(expression="(binomial(k-2*n-1,n-1))*(binomial(-6*n+m+2*k-1,m))*k/n").first().limitation_to_eval)
# g = Formula('1 / ((1 - y)**2)')
# db.session.add(g)
# db.session.commit()
# started_at = time.time()
# print(pyr420.get_data(7,7,1))
# pyr420.init_gf_evaluation()
# pyr420.evaluate_certain_gf("U", {"x":2, "y": 3})
# for _ in range(49):
    # pyr420.evaluate_gf_at(2, 3)
# pyr420.init_ef_evaluation()
# print('answer is', pyr420.evaluate_ef_at(2, 0, 4))
# print(Pyramid)
# ended_at = time.time()

# print(f'Execution time: {ended_at - started_at}')

# print(pyr420.generating_function.append(Formula.query.first()))

# for formula in pyr420.generating_function:
#     print(formula.get_latex())
# print(pyr420)

# pyr2 = Pyramid.query.filter_by(sequence_number=2).first()
# print(pyr2.evaluate_gf_at(30, 30))

# for pyramid in Pyramid.query.all():
#     pyramid.init_special_value()

def testfunc(a=1,b=2, c=3):
    print(a,b,c)

l = {'a': 2, 'b':2, 'c':2}
testfunc(*list(zip(l, l.values())))
# print(zip([a, b, c], [2, 3, 4]))