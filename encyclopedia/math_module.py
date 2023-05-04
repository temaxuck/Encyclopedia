import math
import sympy


def formula(cls):
    class ImplicitFormula:
        isImplicit = True

        __call__ = cls.evaluate
        latex = cls.latex

    return ImplicitFormula()


@formula
class kron_delta:
    @property
    def latex(self):
        return r"$$\delta{(a, b)} = \begin{cases}1&\text{if a = b},\\ 0  \end{cases} $$"

    def evaluate(self, a, b):
        return 1 if a == b else 0


def custom_sqrt(value):
    if value < 0:
        return -1
    else:
        return math.sqrt(value)


def cotan(x):
    return 1 / math.tan(x)


def arccotan(x):
    return math.acos(x) / math.asin(x)


@formula
class Tsqrt:
    @property
    def latex(self):
        return (
            r"$$Tsqrt(n, k) = \begin{cases}"
            r"\binom{m}{n} 4^{n}&\text{if k even, where m =} \frac{k} {2},\\"
            r"\frac {{(-1)}^{n-m} \binom{n}{m} \binom{2n}{n}} {\binom{2n}{2m}} &\text{if k odd, n > k, where m =} \frac{k+1} {2},\\"
            r"\frac {\binom{2m}{2n} \binom{2n}{n}} {\binom{m}{n}}&\text{if k odd, n < k, where m =} \frac{k+1} {2},\\"
            r"\end{cases} $$"
        )

    def evaluate(self, n, k):
        from sympy import binomial

        if k % 2 == 0:
            m = k / 2
            return binomial(m, n) * 4**n
        else:
            m = (k + 1) / 2
            if n > k:
                return (
                    (-1) ** (n - m)
                    * binomial(n, m)
                    * binomial(2 * n, n)
                    / binomial(2 * n, 2 * m)
                )
            else:
                return binomial(2 * m, 2 * n) * binomial(2 * n, n) / binomial(m, n)


@formula
class Tsqrt2:
    @property
    def latex(self):
        return (
            r"$$Tsqrt2(n, k) = \begin{cases}"
            r"\frac {k \binom{n+j}{n} \binom{2n+2j}{n+j}} {\binom{2j}{j} {n+k}} &\text{if n+k even, where j =} \frac{n+k} {2},\\"
            r"\frac {k \binom{n+j}{n} \binom{2n+2j}{n+j}} {\binom{2j}{j} {n+k}} &\text{if n+k odd, where j =} \frac{n+k+1} {2},\\"
            r"\end{cases} $$"
        )

    def evaluate(self, n, k):
        from sympy import binomial

        def Tsqrt2_even(n, k):
            return binomial(k, n) * (4**n)

        def Tsqrt2_odd(n, k):
            if n > k:
                return (
                    (-1) ** (n - k)
                    * binomial(2 * n, n)
                    * binomial(n, k)
                    / binomial(2 * n, 2 * k)
                )
            else:
                return binomial(2 * k, 2 * n) * binomial(2 * n, n) / binomial(k, n)

        if (k + n) % 2 == 0:
            return (Tsqrt2_even(n, (k + n) / 2) * k) / (n + k)
        else:
            return (Tsqrt2_odd(n, (k + n + 1) / 2) * k) / (n + k)


@formula
class TA271825:
    @property
    def latex(self):
        return (
            r"$$TA_{271825}(n, k) = \begin{cases}"
            r"1&\text{if n = 0},\\"
            r"\frac {k {(-1)}^{n-1}} {n} {\binom{2n-k-1}{n-1}} &\text{if n > 0},\\"
            r"\end{cases} $$"
        )

    def evaluate(self, n, k):
        from sympy import binomial

        if n == 0:
            return 1
        else:
            return k * (-1) ** (n - 1) / n * binomial(2 * n - k - 1, n - 1)


@formula
class TLeftA271825:
    @property
    def latex(self):
        return (
            r"$$TLeftA_{271825}(n, k) = \begin{cases}"
            r"1&\text{if n = 0},\\"
            r"\frac {k {(-1)}^{n-1}} {n} {\binom{3n-k-1}{n-1}} &\text{if n > 0},\\"
            r"\end{cases} $$"
        )

    def evaluate(self, n, k):
        from sympy import binomial

        if n == 0:
            return 1
        else:
            return k * (-1) ** (n - 1) / n * binomial(3 * n - k - 1, n - 1)


@formula
class TA984:
    @property
    def latex(self):
        return (
            r"$$TA_{984}(n, k) = \begin{cases}"
            r"{4}^{n} \binom {n+j-1} {n} &\text{if k even, where j =} \frac {k} {2},\\"
            r"\frac {\binom {n+j} {n} \binom {2n+2j} {n+j}} {\binom {2j} {j}}&\text{if k odd, where j =} \frac {k-1} {2},"
            r"\end{cases} $$"
        )

    def evaluate(self, n, k):
        from sympy import binomial

        if k % 2 == 0:
            j = k / 2
            return (4**n) * (binomial(n + j - 1, n))
        else:
            j = (k - 1) / 2
            return (binomial(n + j, n) * binomial(2 * n + 2 * j, n + j)) / binomial(
                2 * j, j
            )


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
    "parity": {
        "even": "% 2 == 0",
        "uneven": "% 2 == 1",
        "odd": "% 2 == 1",
    },
    "separators": {",": " and "},
    "equal": {"=": "=="},
    "math": {
        "sqrt": math.sqrt,
        "sin": math.sin,
        "cos": math.cos,
        "arcsin": math.asin,
        "asin": math.asin,
        "arccos": math.acos,
        "acos": math.acos,
        "tan": math.tan,
        "tg": math.tan,
        "cotan": cotan,
        "ctg": cotan,
        "arctg": math.atan,
        "arctan": math.atan,
        "arccotan": arccotan,
        "arccot": arccotan,
    },
    "combinatorics": {
        "delta": kron_delta,
        "kron_delta": kron_delta,
        "binomial": sympy.binomial,
        "Tsqrt": Tsqrt,
        "Tsqrt2": Tsqrt2,
        "TA271825": TA271825,
        "TA984": TA984,
        "TLeftA271825": TLeftA271825,
    },
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
