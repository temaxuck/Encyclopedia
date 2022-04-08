import math
import sympy

def kron_delta(a, b):
    return 1 if a == b else 0

def custom_sqrt(value):
    if value < 0:
        return -1
    else:
        return math.sqrt(value)
    
def cotan(x):
    return (1/math.tan(x))

def arccotan(x):
    return (math.acos(x)/ math.asin(x))

OPERATIONS = {
    'parity': {
        'even': '% 2 == 0',
        'uneven': '% 2 == 1',
        'odd': '% 2 == 1',
    },
    'separators': { ',': ' and ' },
    'equal': { '=': '==' },
    'math': {
        'sqrt': math.sqrt,
        'sin': math.sin,
        'cos': math.cos,
        'arcsin': math.asin,
        'arccos': math.acos,
        'tan': math.tan,
        'tg': math.tan,
        'cotan': cotan,
        'ctg': cotan,
        'arctg': math.atan,
        'arctan': math.atan,
        'arccotan': arccotan,
        'arccot': arccotan
    },
    'combinatorics': {
        'delta': kron_delta,
        'binomial': sympy.binomial
    }
}


# def Taylor_polynomial_sympy(function_expression, variable_list, evaluation_point, degree):
#     from sympy import factorial, Matrix, prod
#     import itertools

#     n_var = len(variable_list)
#     # list of tuples with variables and their evaluation_point coordinates, to later perform substitution
#     point_coordinates = [(i, j)
#                          for i, j in (zip(variable_list, evaluation_point))]

#     # list with exponentials of the partial derivatives
#     deriv_orders = list(itertools.product(range(degree + 1), repeat=n_var))
#     deriv_orders = [deriv_orders[i] for i in range(len(deriv_orders)) if sum(
#         deriv_orders[i]) <= degree]  # Discarding some higher-order terms
#     n_terms = len(deriv_orders)
#     deriv_orders_as_input = [list(sum(list(zip(variable_list, deriv_orders[i])), ())) for i in range(
#         n_terms)]  # Individual degree of each partial derivative, of each term

#     polynomial = 0
#     for i in range(n_terms):
#         partial_derivatives_at_point = function_expression.diff(
#             *deriv_orders_as_input[i]).subs(point_coordinates)  # e.g. df/(dx*dy**2)
#         denominator = prod([factorial(j)
#                            for j in deriv_orders[i]])  # e.g. (1! * 2!)
#         distances_powered = prod([(Matrix(variable_list) - Matrix(evaluation_point))[
#                                  j] ** deriv_orders[i][j] for j in range(n_var)])  # e.g. (x-x0)*(y-y0)**2
#         polynomial += partial_derivatives_at_point / denominator * distances_powered
#     return polynomial

# def get_coeffs(sFunc):
#     from sympy.parsing.sympy_parser import parse_expr
#     expr1 = parse_expr(sFunc, evaluate=False)
#     # print(expr1)
#     function_expression = expr1
#     variable_list = [x, y]
#     evaluation_point = [0, 0]
#     degree = 8
#     Polyn = expr1.subs(x, x*eps).subs(y, y*eps).series(eps,
#                                                        n=7).removeO().subs(eps, 1)
#     Proto("Polyn", str(Polyn))
#     # print(GetCoeff2(Polyn,x,y))
#     return (GetCoeff2(Polyn, x, y))