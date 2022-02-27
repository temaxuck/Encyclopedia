from datetime import datetime
from encyclopedia.modules.PyBasePyrUU import *
from encyclopedia.modules.PyrBaseAllTT import *
from sympy import *
from math import *
import webbrowser
import re
import sympy as sym
from sympy.printing.mathml import print_mathml
from sympy.parsing.sympy_parser import parse_expr
from datetime import datetime
import cgi
import cgitb
import os
import pathlib

script_path = os.path.dirname(__file__)  # absolute dir the script is in

x = sym.Symbol('x')
y = sym.Symbol('y')
eps = sym.Symbol('eps')
n = sym.Symbol('n')
m = sym.Symbol('m')


def GetData(pyr, n, m, k):
    Tuuproc = "Tuu{:0>4d}".format(pyr)
    # print(Tuuproc,binomial(5,3))
    for i in range(n):
        for j in range(m):
            print(globals()[Tuuproc](i, j, k), end='')
        print()


def GetDataHtml(pyr, n, m, k):
    Tuuproc = "Tuu{:0>4d}".format(pyr)
    pyramid_as_list = []
    # print(Tuuproc,binomial(5,3))
    html = "<table> "
    for i in range(n):
        for j in range(m):
            data = int(globals()[Tuuproc](i, j, k))
            html += "<td>{}</td>".format(data)
            pyramid_as_list.append(data)
        html += "</tr>"
    html += "</table>"
    return html, pyramid_as_list


def CreateMathmlTable():
    f = open('PyrBaseMathmlAll.txt')
    fw = open("PyrBaseMathmlTable.txt", "w")
    print("EEP", file=fw)
    print("KruMathMlTable: version 001", file=fw)
    print('Время: ', datetime.today(), file=fw)
    print("Size: 1001", file=fw)
    bufs = ''
    k = 0
    for line in f:
        if line[0] != '\n':
            bufs = bufs+line

    j = 0
    m = 0

    ss = re.split(
        "<msub>\s+<mi>T</mi>\s+<mrow class=\"MJX-TeXAtom-ORD\">\s+<mn>", bufs)
    for i in range(len(ss)):
        r = re.search("</mn>", ss[i])
        if r != None:
            pyr = int(ss[i][:r.start()])
            print("#----", ss[i][:r.start()], file=fw)
            print("{:0>4d}".format(pyr), file=fw)
            ss[i] = "<msub> <mi>T</mi> <mrow class=\"MJX-TeXAtom-ORD\"> <mn>"+ss[i]
            print(ss[i], file=fw)
            print("/----", file=fw)
    print("#endtable", file=fw)
    print("PyrBaseMathmlTable.txt is created!!!")
    fw.close()
    f.close()

# загрузка таблицы mathml


def GetMathmlTable():
    f = open("PyrBaseMathmlTable.txt")
    # skip header
    for i in range(3):
        f.readline()
    line = f.readline()
    sizetable = int(re.sub("Size: ", "", line))
    # print(sizetable)

    flag = 1
    mathml_table = {}
    while(flag):
        line = f.readline()
        # print(line)
        r = re.match("#endtable", line)
        if r != None:
            flag = 0
            break
        r = re.match("#----", line)
        if r != None:
            id = f.readline()[:4]
            # print(len(id))
            # print(id,len(id))
            smathml = ''
            for ln in f:
                r = re.match("/----", ln)
                if r != None:
                    mathml_table[id] = smathml
                    break
                else:
                    smathml += ln

    f.close()
    return(mathml_table)


def GetCoeff2(Polyn, x, y):
    M = []
    for n in range(4):
        s = []
        for m in range(4):
            z = (Polyn.coeff(x, n)).coeff(y, m)
            s.append(z)
        M.append(s)
    return(M)


def Taylor_polynomial_sympy(function_expression, variable_list, evaluation_point, degree):
    from sympy import factorial, Matrix, prod
    import itertools

    n_var = len(variable_list)
    # list of tuples with variables and their evaluation_point coordinates, to later perform substitution
    point_coordinates = [(i, j)
                         for i, j in (zip(variable_list, evaluation_point))]

    # list with exponentials of the partial derivatives
    deriv_orders = list(itertools.product(range(degree + 1), repeat=n_var))
    deriv_orders = [deriv_orders[i] for i in range(len(deriv_orders)) if sum(
        deriv_orders[i]) <= degree]  # Discarding some higher-order terms
    n_terms = len(deriv_orders)
    deriv_orders_as_input = [list(sum(list(zip(variable_list, deriv_orders[i])), ())) for i in range(
        n_terms)]  # Individual degree of each partial derivative, of each term

    polynomial = 0
    for i in range(n_terms):
        partial_derivatives_at_point = function_expression.diff(
            *deriv_orders_as_input[i]).subs(point_coordinates)  # e.g. df/(dx*dy**2)
        denominator = prod([factorial(j)
                           for j in deriv_orders[i]])  # e.g. (1! * 2!)
        distances_powered = prod([(Matrix(variable_list) - Matrix(evaluation_point))[
                                 j] ** deriv_orders[i][j] for j in range(n_var)])  # e.g. (x-x0)*(y-y0)**2
        polynomial += partial_derivatives_at_point / denominator * distances_powered
    return polynomial


def GetCoeffsFunc(sFunc):
    from sympy.parsing.sympy_parser import parse_expr
    try:
        expr1 = parse_expr(sFunc, evaluate=False)
        # print(expr1)
        function_expression = expr1
        variable_list = [x, y]
        evaluation_point = [0, 0]
        degree = 8

        Polyn = (Taylor_polynomial_sympy(function_expression,
                 variable_list, evaluation_point, degree))
        Proto("Polyn2", str(Polyn))
        # print(GetCoeff2(Polyn,x,y))
        return (GetCoeff2(Polyn, x, y))
    except:
        print("Error")
        return None


def GetCoeffsFunc2(sFunc):
    from sympy.parsing.sympy_parser import parse_expr
    expr1 = parse_expr(sFunc, evaluate=False)
    # print(expr1)
    function_expression = expr1
    variable_list = [x, y]
    evaluation_point = [0, 0]
    degree = 8
    Polyn = expr1.subs(x, x*eps).subs(y, y*eps).series(eps,
                                                       n=7).removeO().subs(eps, 1)
    Proto("Polyn", str(Polyn))
    # print(GetCoeff2(Polyn,x,y))
    return (GetCoeff2(Polyn, x, y))


def FindFuncPyr(M):
    n = len(M)
    for pyr in range(1, 1002):
        try:
            Tuuproc = "Tuu{:0>4d}".format(pyr)
            for i in range(4):
                for j in range(4):
                    data = int(globals()[Tuuproc](i, j, 1))
                    if data != M[i][j]:
                        raise
            return(pyr)
        except:
            continue
    return(0)


def FindFuncPyr2(M):
    ListPyr = []
    n = len(M)
    for pyr in range(1, 1002):
        try:
            Tuuproc = "Tuu{:0>4d}".format(pyr)
            for i in range(n):
                m = len(M[i])
                for j in range(m):
                    data = int(globals()[Tuuproc](i, j, 1))
                    if M[i][j] == "*":
                        continue
                    if abs(data) != (M[i][j]):
                        raise
            ListPyr.append(pyr)
        except:
            continue
    return(ListPyr)


def FindFuncPyrF(F):
    '''
    sp=""
    for i in range(5):
        for j in range(5):
          sp=sp+str(F(i,j))
    Proto("Ft:=:",sp)
    '''
    for pyr in range(1, 1002):
        try:
            Tuuproc = "Tuu{:0>4d}".format(pyr)
            # Proto("F=",Tuuproc)
            for i in range(4):
                for j in range(4):
                    Proto("F=", str(F(i, j)))
                    data = int(globals()[Tuuproc](i, j, 1))
                    if data != int(F(i, j)):
                        raise
            return(pyr)
        except:
            continue
    return(0)


class KruPyramid:

    def __init__(self, pyr, PathExe):
        self.pyr = pyr
        self.spyr = "{:0>4d}".format(pyr)
        self.k = 1
        self.PathExe = PathExe
        # Read TTMML
        # Proto("MML",self.PathExe)
        try:
            fma = open(str(self.PathExe)+"\\MML\\MML"+self.spyr+".txt")
            self.smml = ''
            for line in fma:
                self.smml = self.smml+line
            fma.close()
            self.smml = self.smml[5:]
            # Proto("2",self.smml)
        except Exception as e:
            print(e)
            # Proto("3","+++")
            self.smml = ''

            # Read UUMML
        UUspyr = "UU"+self.spyr
        ttproc = "Tuu{:0>4d}".format(pyr)
        self.GeneratingFunction = globals()[UUspyr](x, y)
        try:
            self.ExplicitFormula = globals()[ttproc](n, m, k)
        except:
            self.ExplicitFormula = ''
        try:
            fuumml = open(self.PathExe+"\\UUMML\\UUMML"+str(pyr)+".txt")
            self.uumml = ''
            for line in fuumml:
                self.uumml = self.uumml+line
        except:
            self.uumml = sym.mathml(
                self.GeneratingFunction, "*", fold_frac_powers=True)
            self.uumml = "<math xmlns=\"http://www.w3.org/1998/Math/MathML\" display=\"block\">" + \
                self.uumml+"</math>"
        # Get Data
        self.sdata, self.pyramid_as_list = GetDataHtml(self.pyr, 7, 7, self.k)
        # Get Url

        self.url = ReadUrlPyrFile(
            self.PathExe, "\\PyramidsSystem2.py", self.pyr)
        self.UUMaxima = ReadUUMaximaFile(self.PathExe, self.pyr)
        #Proto("URL: ",self.url)

    def GetHtmlTable(self):
        # self.k=1
        #shtml="table</title>\n   <style>\n   table {\n     width: 100%;\n  background: white;\n  color: black;\n border-spacing: 1px;\n }"
        #shtml="td, th {    background: white;\n  padding: 5px;\n  } </style> </head> <body>"
        shtml = "<table> <tr><th>Pyramid "+str(self.pyr)+"</th></tr>\n"
        shtml = shtml+"<tr><td> Generating Function:</td></tr>\n"
        shtml = shtml+"<tr><td>"
        shtml = shtml+self.uumml
        shtml = shtml+"</td></tr>"
        shtml = shtml+"<tr><td> Explicit Formula:</td></tr>\n"
        shtml = shtml+"<tr><td>"
        shtml = shtml+self.smml
        shtml = shtml+"</td></tr>"
        shtml = shtml+"<tr><td> Data:</td></tr>\n"
        shtml = shtml+"<tr><td>\n"
        shtml = shtml+self.sdata
        shtml = shtml+"</td></tr></table>\n"
        if self.url != None:
            shtml = shtml+self.url
        # if self.UUMaxima != None:
        #     shtml = shtml+self.UUMaxima

        return (shtml)

    def Send(self, shtml):
        shtml = re.sub("PYRTTMML", self.smml, shtml)
        shtml = re.sub("PYRUUMML", self.uumml, shtml)
        shtml = re.sub("PYRDATA", self.sdata, shtml)
        # Proto("1",shtml)
        print(shtml)

    def Send2(self):
        s1 = "Content-type:text/html\n\
\n\
<html>\
<head>\n\
  <meta charset=\"utf-8\">\n\
  <title>Online Encyclopedia of Number's Pyramids</title>\n\
  <script>window.MathJax = { MathML: { extensions: [\"mml3.js\", \"content-mathml.js\"]}};</script>\n\
<script type=\"text/javascript\" async src=\"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=MML_HTMLorMML\"></script>\n\
</head>\n\
<body>\n\
\n\
<form name=\"Form1\" method=\"post\" action=\"PyramidsSystem2.py\">\n\
  <p><b>Input:</b><br>\
   <input name=\"pyra\" type=\"text\" size=\"40\">\
  </p>\
 </form>\
\n\
<form name=\"Form2\" method=\"post\" action=\"PyramidsSystem2.py\">\n\
    <p><b>Find Pyr Func(x,y):</b><br>\
   <input name=\"expr\" type=\"text\" size=\"40\">\n\
  </p>\
</form>\n\
\n\
<form name=\"Form3\" method=\"post\" action=\"PyramidsSystem2.py\">\n\
    <p><b>Find Pyr T(n,m):</b><br>\
   <input name=\"texpr\" type=\"text\" size=\"40\">\n\
  </p>\
</form>\n\
<title>Тег table</title>\n\
  <style>\n\
   table {\n\
    width: 100%;    background: white;    color: white;    border-spacing: 1px;  }\
   td, th {    background: maroon; padding: 5px;  }  </style> </head>"

        cpyr = self.GetHtmlTable()
        s1 = s1+cpyr+"</body>\n</html>"
        # Proto("+++",s1)
        print(s1)


# ---------------------------------------------------------------------------------------------------------
#
'''
<form name=\"Form2\" method=\"post\" action=\"PyramidsSystem2.py\">\n\
    <p><b>Find Pyr Func(x,y):</b><br>\
   <input name=\"expr\" type=\"text\" size=\"40\">\n\
  </p>\
</form>\n\
\n\
<form name=\"Form3\" method=\"post\" action=\"PyramidsSystem2.py\">\n\
    <p><b>Find Pyr T(n,m):</b><br>\
   <input name=\"texpr\" type=\"text\" size=\"40\">\n\
  </p>\
</form>\n\
'''


def SendListPyramid(ListPyr, PathExe):
    # ggggg=1
    s1 = "Content-type:text/html\n\
\n\
<html>\
<head>\n\
  <meta charset=\"utf-8\">\n\
  <title>Online Encyclopedia of Number's Pyramids</title>\n\
  <script>window.MathJax = { MathML: { extensions: [\"mml3.js\", \"content-mathml.js\"]}};</script>\n\
<script type=\"text/javascript\" async src=\"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=MML_HTMLorMML\"></script>\n\
<style>\
p{\
    line-height: 0.9em;\
   }\
label{\
font-size: .8rem;\
letter-spacing: 0.1px;\
     resize: none;\
     line-height: 1;\
}\
textarea {\
    font-size: .9rem;\
    letter-spacing: 0.5px;\
     resize: none;\
}\
textarea {\
    padding: 10px;\
    max-width: 100%;\
    line-height: 1;\
    border-radius: 5px;\
    border: 1px solid #ccc;\
    box-shadow: 1px 1px 1px #999;\
}\
</style>\
</head>\n\
<body>\n\
\n\
<form name=\"Form1\" id=\"data\" method=\"post\" action=\"PyramidsSystem2.py\">\n\
  <label><b>Input:</b>\
   <input name=\"pyra\" type=\"text\" size=\"60\">\
<button type=\"submit\" form=\"data\" value=\"Submit\">Search</button>\
    </label>\
  </p>\
 </form>\
\
\n\
<title>Тег table</title>\n\
  <style>\n\
   table {\n\
    width: 100%;    background: white;    color: black;   border: 1px solid gray;  border-spacing: 1px;  }\
   td, th {    background: rgb(241, 245, 249); padding: 5px;  }  </style> </head>"
    for npyr in ListPyr:
        Pyramid = KruPyramid(npyr, PathExe)
        content = Pyramid.GetHtmlTable()
        s1 = s1+content
    s1 = s1+"</body>\n</html>"
    # Proto("+++",s1)
    # print(s1)
    # print(Pyramid.GeneratingFunction)
    return Pyramid

# ----------------------------------------------------------------------------------------------


class InUser():
    def __init__(self, cmd, expr, pyr, mass, emess):
        self.cmd = cmd
        self.expr = expr
        self.mass = mass
        self.pyr = pyr
        self.emess = emess

    def GetCmd(self):
        return (self.cmd)

    def GetExpr(self):
        return(self.expr)

    def GetMass(self):
        return self.mass

    def GetPyr(self):
        return(self.pyr)

    def GetEmess(self):
        return (self.emess)

    def SetEmess(self, s):
        self.emess = s


def AnalysInputStr(input):
    input = str(input)
    inu = InUser(0, None, None, None, "Error Input Command:"+input)
    r = re.match("\s*F:", input)

    if r != None:
        par = input[r.end():]
        r = re.match("\s*", par)
        try:
            fexpr = parse_expr(par[r.end():], evaluate=False)
            inu = InUser(1, fexpr, None, None, None)
            return inu
        except:
            inu.SetEmess("Syntax Error Expression:"+par[r.end():])
            return inu

    else:
        r = re.match("\s*T:", input)
        if r != None:
            par = input[r.end():]
            r = re.match("\s*", par)
            try:
                fexpr = parse_expr(par[r.end():], evaluate=False)
                inu = InUser(2, fexpr, None, None, None)
                return inu

            except:

                inu.SetEmess("Syntax Error Expression:"+par[r.end():])
                return inu
        else:
            r = re.match("\s*N:", input)
            if r != None:
                par = input[r.end():]
                r = re.match("\s*", par)
                try:
                    pyr = int(par[r.end():])
                except:
                    inu.SetEmess("Error Syntax of Number:"+par[r.end():])
                    return inu

                if pyr <= 0 or pyr > 1001:
                    inu.SetEmess(
                        "Error: Pyramid no have this number:"+par[r.end():])
                    #print("Error: Pyramid no have this number:",par[r.end():])
                    return inu
                else:
                    inu = InUser(3, None, pyr, None, None)
                    return inu

            else:
                r = re.match("\s*D:", input)
                if r != None:
                    par = input[r.end():]
                    r = re.match("\s*", par)
                    # print(r)
                    lis = re.findall("\w+|;", par[r.end():])
                    # print(lis)
                    M = []
                    L = []
                    for sn in lis:
                        # print("++",sn)
                        r = re.match(";", sn)
                        # print(r)
                        if r != None:
                            if L != []:
                                M.append(L)
                                L = []
                        else:
                            # print("==",sn)
                            if sn == "*":
                                v = "*"
                            try:
                                v = int(sn)
                            except:
                                #print("Error syntacs  number:",sn)
                                inu.SetEmess("Error syntacs of number:"+sn)
                                return inu
                                break
                            L.append(v)
                    if L != []:
                        M.append(L)

                    inu = InUser(4, None, None, M, None)
                    return inu
                    # print(M)

        r = re.match("\s*", input)
        if r != None:
            try:
                pyr = int(input[r.end():])
                if pyr <= 0 or pyr > 1001:
                    inu.SetEmess(
                        "Error: Pyramid no have this number:"+par[r.end():])
                    #print("Error: Pyramid no have this number:",par[r.end():])
                    return inu
                inu = InUser(3, None, pyr, None, None)
                return inu
            except:
                return inu
# ----------------------------------------------------------------------------------------------
# ErrorMess


def ErrorMessage(Emess):
    print("Content-type: text/html")
    print()
    print("<h1>EENP===> "+Emess+"</h1>")


# ----------------------------------------------------------------------------------------------
def Proto(b, s):

    fpro = open(script_path + '/bin/Proto.txt', "a")
    print(datetime.now(), " ", b, s, file=fpro)
    fpro.close()
# ----------------------------------------------------------------------------------------------
# read URL reciprical, Oeis ...


def ReadUrlPyrFile(Path, Proga, pyr):
    # spa=''
    # for j in range(len(Path)):
    # spa=spa+"#"
   # Proto("ReadUrl",Path)
    try:
        furl = open(Path+"\\URLPYR\\"+"urlpyr"+str(pyr)+".txt")
        shtml = ''
        for line in furl:
            shtml = shtml+line
        furl.close()
        # PathRef=os.environ['HTTP_REFERER']
        # r=re.Search("?",PathRef)
        # if r!=None:
        # PathRef=Pathref[:r.Start()]
        # Proto("PathRef",Pathref)
        # shtml=shtml.replace("[PATHPROGA]","")

        shtml = shtml.replace("[PATHPROGA]", "http://localhost:8000/cgi-bin")
        shtml = shtml.replace("[PROGA]", Proga)
        shtml = shtml.replace("<p>", "<p style=\"margin-bottom: 0px;\">")
        # shtml=shtml.replace("[PROGA]","")
        # shtml=shtml+"<a href=\"http://localhost:8000/cgi-bin/PyramidsSystem2.py? -10\">Maxima: </a>"+" <a href=\"http://localhost:8000/cgi-bin/PyramidsSystem2.py? -20\">Mathematica: </a>"\
        #+" <a href=\"http://localhost:8000/cgi-bin/PyramidsSystem2.py? -30\">Latex:</a>"

        #shtml=shtml+"<p><label for=\"story\">Maxima:</label></p>\n\n\n"

        #shtml=shtml+"<textarea id=\"story\" name=\"story\" rows=\"3\" cols=\"120\" disabled>  Tuu0079(n,m,k):=if n=0 then if m=0 then 1 else k/m*binomial(2*m-k-1,m-1)*(-1)^(m-1) else (2*k*(binomial(k-m,m))*(binomial(2*(k-m)-1,n-1)))/(n)  </textarea>\n"
        return shtml
    except:
        return None


def ReadUUMaximaFile(Path, pyr):
    try:
        fuu = open(Path+"\\UUMAXIMA\\"+"UUMaxima"+"{:0>4d}".format(pyr)+".txt")
        ss = ''
        for line in fuu:
            line = re.sub("\s", "", line)
            ss = ss+line
        fuu.close()
        ss = ss+"\n"
    except:
        ss = ''
    try:
        ftt = open(Path+"\\TTMAXIMA\\"+"TTMaxima"+"{:0>4d}".format(pyr)+".txt")
        tt = ''
        for line in ftt:
            tt = tt+line
        ftt.close()

    except:
        tt = ''

    from sympy import mathematica_code as mcode, symbols, sin, binomial
    x, y, n, m, k = symbols('x y n m k')
    uuproc = "UU{:0>4d}".format(pyr)

    exp = globals()[uuproc](x, y)
    try:
        uum = uuproc+"[x_,y_]:="+str(mcode(exp))+"\n"
    except:
        uum = "Error convert"
        Proto("Error convert: ", uuproc)

    ttproc = "Tuu{:0>4d}".format(pyr)

    try:
        exp1 = globals()[ttproc](n, m, k)
        ttm = ttproc+"[n_,m_,k_]:="+str(mcode(exp1))+"\n"
    except:
        ttm = "Error convert"
        Proto("Error convert: ", ttproc)
    
    # print('maxima', ss, tt,'mathematica', uum, ttm)

    shtml = "<p style=\"margin-bottom: 0px;\"><label for=\"story\">Maxima:</label></p>"
    shtml = shtml+"<textarea id=\"story\" name=\"story\" rows=\"4\" cols=\"120\" disabled>"+ss+tt+"</textarea>"

    shtml = shtml+"<p style=\"margin-bottom: 0px;\"><label for=\"story1\">Mathematica:</label></p>"
    shtml = shtml+"<textarea id=\"story1\" name=\"story\" rows=\"4\" cols=\"120\" disabled>" + \
        uum+ttm+"</textarea>\n"

    return [ss, tt, uum, ttm]


def get_user_input(_input_):
    UI = AnalysInputStr(_input_)
    x, y, n, m, k = symbols('x y n m k')

    if UI.GetCmd() == 1: # Generating function
        sfunc = str(UI.GetExpr())
        M = GetCoeffsFunc2(sfunc)
        print(M)
        r = FindFuncPyr(M)
        if r == 0:
            ErrorMessage("Nothing of find for "+sfunc)
        else:
            ListPyr = [r]
            Pyramid = SendListPyramid(ListPyr, script_path)
        return Pyramid

    elif UI.GetCmd() == 2: # Explicit formula
        tfunc = str(UI.GetExpr())
        tfu = sym.lambdify((n,m),tfunc,modules='sympy')
        r = FindFuncPyrF(tfu)
          
        if r == 0:
            ErrorMessage("Nothing of find for "+tfunc)
        else:
            pyr = r
            ListPyr = [r]
            Pyramid = SendListPyramid(ListPyr, script_path)
        return Pyramid

    elif UI.GetCmd() == 3: # Number
        pyr = UI.GetPyr()
        ListPyr = [pyr]
        Pyramid = SendListPyramid(ListPyr, script_path)
        return Pyramid

    elif inu.GetCmd()==4: #D command
        M=inu.GetMass()
        if M==[]:
            ErrorMessage("Nothing data for find")
        else:    
            s=''
            for i in range(len(M)):
                m=len(M[i])
                for j in range(m):
                    if j<m-1:
                        s=s+str(M[i][j])+", "
                    else:
                        s=s+str(M[i][j])+"; "
            ListPyr=FindFuncPyr2(M)
            if ListPyr==[]:
                ErrorMessage("Nothing of find for "+s)
            else:
                SendListPyramid(ListPyr,PathExe)
        return Pyramid

if __name__ == '__main__':
    print(script_path)
    UI = AnalysInputStr("F:-(sqrt(-4*x*y-4*x+1)-1)/(2*x*y+2*x);")
    pyr = UI.GetPyr()
    ListPyr = [pyr]
    Pyramid = SendListPyramid(ListPyr, script_path)
    print(Pyramid.pyramid_as_list)  # pyramid as list
    print(Pyramid.uumml)  # generating function
    print(Pyramid.smml)  # explicit formula
    print(Pyramid.UUMaxima)
