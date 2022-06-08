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

def Tsqrt(n, k):
    from sympy import binomial
    if k % 2 == 0:
        m = k / 2
        return binomial(m,n) * 4 ** n
    else:
        m = (k + 1) / 2
        if n > k:
            return (-1)**(n-m) * binomial(n, m) * binomial(2*n, n) / binomial(2*n, 2*m)
        else:
            return binomial(2*m, 2*n) * binomial(2*n, n) / binomial(m, n)
        
def TA271825(n, k):
    from sympy import binomial
    if n == 0:
        return 1
    else:
        return k*(-1)**(n-1) / n * binomial(2*n-k-1, n-1) 
    
def TLeftA271825(n, k):
    from sympy import binomial
    if n == 0:
        return 1
    else:
        return k*(-1)**(n-1) / n * binomial(3*n-k-1, n-1) 

def TA984(n, k):
    from sympy import binomial
    if k % 2 == 0:
        j = k / 2
    else:
        j = (k - 1) / 2
        
    return binomial(n+j, n) * binomial(2*n + 2*j, n+j) / binomial(2*j, j)

# def Tsqrt2(n,k):
#     if evenp(k+n):
#         return (Tsqrt_even(n,((k+n)/2))*k/(n+k))
#     else:
#         return (Tsqrt_odd(n,(n+k+1)/2)*k/(n+k));


# def TLeftA271825(n,k):
#     if n==0:
#         return (1)
#     else:
#         return ((k*((binomial(3*n-k-1,n-1))*(-1)**(n-1)))/n)

# def TA000984(n,k):
#     if evenp(k):
#         return (4**n*(binomial(n+int(k/2)-1,n)))
#     else:
#         return(binomial(n+int((k-1)/2),n)*binomial(2*n+k-1,n+int((k-1)/2))/binomial(k-1,int((k-1)/2)))

# def Tsqrt3(n,k):
#     if n==0:
#         return (1)
#     else:
#         return (2*binomial(2*n-2*k-1,n-1)*k/n*(-1)**(n-1))

# def TCube5(n,k):
#     if n==0:
#         return (1)
#     else:
#         return (2*k*binomial(3*n-2*k-1,n-1)/n*(-1)**(n-1))



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
        'asin': math.asin,
        'arccos': math.acos,
        'acos': math.acos,
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
        'binomial': sympy.binomial,
        'Tsqrt': Tsqrt,
        'TA271825': TA271825,
        'TA984': TA984,
        'TLeftA271825': TLeftA271825
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