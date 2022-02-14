#специальные функции
from sympy import *
from math import *


def kron_delta(n,k):
    if n==k:
        return True
    return False

def evenp(n):
    if n%2==0:
        return True
    return False

def oddp(number):
    if number%2==0:
        return False
    return True

def mod(n,m):
    return (int(n)%int(m))

def Tsqrt_odd(n,k):
    if n>k:
        return((-1)**(n-k)*binomial(2*n,n)*binomial(n,k)/binomial(2*n,2*k))
    else:
        return (binomial(2*k,2*n)*binomial(2*n,n)/binomial(k,n))

def Tsqrt_even(n,k):
    return (binomial(k,n)*4**n)

def Tsqrt(n,k):
    if evenp(k):
        return(Tsqrt_even(n,k/2))
    else:
        return Tsqrt_odd(n,(k+1)/2)

def Tsqrt2(n,k):
    if evenp(k+n):
        return (Tsqrt_even(n,((k+n)/2))*k/(n+k))
    else:
        return (Tsqrt_odd(n,(n+k+1)/2)*k/(n+k));

def TA271825(m,k):
    if m==0:
        return (1)
    else:
        return ((k*((binomial(2*m-k-1,m-1))*(-1)**(m-1)))/m)

def TLeftA271825(n,k):
    if n==0:
        return (1)
    else:
        return ((k*((binomial(3*n-k-1,n-1))*(-1)**(n-1)))/n)

def TA000984(n,k):
    if evenp(k):
        return (4**n*(binomial(n+int(k/2)-1,n)))
    else:
        return(binomial(n+int((k-1)/2),n)*binomial(2*n+k-1,n+int((k-1)/2))/binomial(k-1,int((k-1)/2)))

def Tsqrt3(n,k):
    if n==0:
        return (1)
    else:
        return (2*binomial(2*n-2*k-1,n-1)*k/n*(-1)**(n-1))

def TCube5(n,k):
    if n==0:
        return (1)
    else:
        return (2*k*binomial(3*n-2*k-1,n-1)/n*(-1)**(n-1))