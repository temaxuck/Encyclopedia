��    �      $              ,  �  -  k   >�  O   ��     ��      �     �     /�  (   ;�     d�     k�     ��     ��  /   ��  2   ��  U   ��  p   O�  M   ��  L   �  Q   [�  M   ��  	   ��     �     �     '�     ,�  
   G�     R�      m�     ��  �   ��     ��     ��  1   ��     ��     ��     �     
�     �     $�     6�  1   <�     n�     w�     ��     ��     ��  
   ��     ��     ��     ��  &   ��  N    �  J   o�  n   ��  #   )�  8   M�  N   ��  S   ��     )�     7�     J�  2   ^�  $   ��  (   ��     ��     ��     �  #   $�     H�     _�      d�     ��     ��     ��     ��     ��     ��     �     %�     D�     Q�  !   d�     ��     ��  Q   ��  a   ��  b   I�     ��     ��     ��     ��     ��     ��     ��     �  
   �     �     %�     1�     >�     E�     Y�  	   e�     o�     ��  .   ��  4   ��  +   ��  <    �  F   ]�     ��     ��     ��     ��  $   ��  '        4     =  '   O  2   w  #   �     �     �     �         "    '    * �  9 iA  �   }D �   'E    �E *   �E ,   �E +   )F F   UF 
   �F '   �F     �F    �F C   G b   EG m   �G �   H i   �H i   (I q   �I c   J    hJ '   wJ )   �J    �J .   �J    K -   +K )   YK    �K �  �K    aM    �M :   �M $   �M #   �M !   N )   >N +   hN )   �N    �N U   �N    !O    0O    JO %   YO &   O    �O <   �O    �O    P N   4P f   �P f   �P �   QQ M   R h   YR t   �R ~   7S    �S #   �S '   �S d   T A   }T <   �T =   �T )   :U $   dU    �U -   �U    �U 6   �U =   V    OV H   mV    �V 8   �V -   W 8   9W 6   rW !   �W 0   �W 7   �W 
   4X 
   ?X �   JX �   �X �   qY ,   �Y    *Z    ;Z ,   HZ    uZ t   �Z    [    [    0[ #   C[    g[ %   �[ 
   �[    �[    �[    �[ (   �[ $   \ �   >\ k   �\ K   9] {   �] �   ^ ,   �^ 8   �^ #   �^    _ t   6_ P   �_    �_ H   ` J   e` X   �` =   	a &   Ga +   na @   �a :   �a    b    6b &   =b   <div class="page"> <div id="1" class="article"> 1. Why do we need another encyclopedia on mathematics </div> <div class="paragraph"> Mathematical knowledge bases are the development of mathematical reference books and encyclopedias and are becoming an important tool in mathematical research and in research in related fields.Examples of such databases knowledge is an online encyclopedia of whole sequences <a href="#18" class="ref_link">[1]</a>, server combinatorial objects <a href="#18" class="ref_link">[2]</a>, etc. </div> <div class="paragraph"> Let's consider one of the most famous such knowledge bases - the online encyclopedia of whole sequences (www.oeis.org ), which has over three hundred thousand sequences. Every day tens of thousands of mathematicians, engineers and students use this encyclopedia in their work when conducting research and training sessions. Each article of this encyclopedia contains <a href="#18" class="ref_link">[1]</a>: </div> <ol id="education"> <li>Numerical sequence;</li> <li> Comments describing mathematical objects related to this sequence; </li> <li> Formulas defining this sequence (generating function, explicit or recurrent formula, equation; </li> <li>References related to this sequence;</li> <li> Implementation of formulas or algorithms for calculating this sequence in various programming systems (Maxima, Mathematica, Maple, etc.; </li> <li>Environment of links to Internet resources;</li> <li>Usage examples;</li> <li>Relation to other sequences;</li> <li> The author of this sequence and the authors of the individual elements of this sequence. </li> </ol> <div class="paragraph"> The main function of this knowledge base is to search and edit numerical sequences, which can be of two types: linear sequence and triangle. The triangle is also represented by a linear sequence. This encyclopedia has a number of significant drawbacks: </div> <ol id="education"> <li>It is impossible to imagine tensors having 3 or more indices;</li> <li>Outdated interface, formulas are written in text mode;</li> <li> The search is implemented only by elements of the numerical sequence; </li> </ol> <div class="paragraph"> The described disadvantages do not detract from the importance of this knowledge base for mathematical research and the practice of using numerical sequences and algorithms. However, the development of the mathematical apparatus of the composition of generating functions of many variables makes it possible to obtain explicit expressions of the coefficients of generating functions of many variables <a href="#18" class="ref_link">[3]</a> and to find approaches and algorithms for implementing this operation in computer algebra systems, and the first step in this direction is to create an appropriate knowledge base for tensors $T(n,m,k)$ described by products of binomial coefficients, which are coefficients -degrees of the generating function of two variables. </div> <div class="paragraph"> The proposed encyclopedia is an addition oeis.org in terms of the representation of the generating functions of two variables and their coefficients of the $k$th degree. </div> <div id="2_art" class="article">2. Why do we need generating functions</div> <div class="paragraph"> Generating functions is a mathematical apparatus that provides the solution of discrete problems using mathematical analysis. Generating functions are widely used in combinatorics, in the analysis of computational complexity of algorithms, in probability theory and mathematical statistics, in solving classes of functional equations, in solving differential equations, in calculating integrals, etc. </div> <div id="3" class="article">3. Features of this encyclopedia</div> <div class="paragraph"> There can be a huge number of generating functions. So, in the online encyclopedia of integers, more than 300 thousand generating functions are recorded. In this encyclopedia there are 1500 generating functions of two variables and their coefficients of the kth degree. Here we present only generating functions whose coefficients of the kth degree are represented by binomial coefficients. It can be hypothesized that the number of generating functions of two variables whose expressions are explicitly given and their coefficients of the kth degree are expressed by binomial coefficients is limited. An example from the encyclopedia of a typical generating function and its coefficients <div class="latex"> $$U_{39}(x,y)= {1-\sqrt{1-4\,x-4\,x\,y}}\over{x\,\left(2+2\,y\right)}$$ </div> Decomposition of the generating function $$\begin{array}{llllll}1&0&0&0&0&0\\1&1&0&0&0&0\\2&4&2&0&0&0\\5&15&15&5&0&0\\14&56&84&56&14&0\\42&210&420&420&210&42\end{array}$$ </div> <div id="4" class="article"> 4. What tasks does this encyclopedia solve? </div> <div> <div class="paragraph"> The development of the methodology for solving problems based on the use of generating functions of many variables, presented in <a href="#18" class="ref_link">[3-12]</a>, has significantly expanded the scope of their application. An important element was the knowledge base for mathematical objects described by coefficients $k$th degrees of the generating function of two variables. It is possible to identify the following tasks, the solution of which can be carried out with the help of this knowledge base: </div> <br /> <ol id="education"> <li> finding an explicit formula for the coefficients of the composition of generating functions and their degrees $$ F(x,y,\ldots,G(x,y,\ldots,z),\ldots,z)^k $$ </li> <li> finding explicit formulas for the mutual generating function and their degrees $$ \frac{1}{G(x,y,\ldots,z)^k} $$ </li> <li> finding explicit formulas for a generating function of the form $$ G(x,y,\ldots,z)^{\alpha} , \alpha\in R $$ </li> <li> finding explicit formulas for the inverse generating function and their degrees; $$ G(x,y,\ldots,z)=\frac{y}{F\left(x,y\cdot G(x,y,\ldots,z),\ldots,z\right)} $$ </li> <li> finding explicit formulas for a reversible generating function and their degrees; \ $$ G(x,y,\ldots,z)=F(x,y\,G(x,y,\ldots,z),\ldots,z) $$ </li> <li> finding explicit formulas for a reversible generating function and their degrees;\ $$ G(x,y,\ldots,z)=F(x,y\,G(x,y,\ldots,z),\ldots,z) $$ </li> <li> finding explicit formulas for the inverse inverse generating function of two variables and their degrees; $$ G(x,y,\ldots,z)=F\left(x,\frac{y}{G(x,y,\ldots,z)},\ldots,z\right) $$ </li> <li> finding explicit expressions of logarithmic derivatives $$ \log(G(x,y,\ldots,z)) $$ </li> </ol> </div> <div id="5" class="article">5. Keywords</div> <div> <ul> <li>generating function</li> <li>ordinary generating function</li> <li>exponential generating function</li> <li>generating function of one variable</li> <li>generating function of two variables</li> <li>generating function of many variables</li> <li>coefficient of the generating function</li> <li>coefficient of the generating function of one variable</li> <li>coefficient of the generating function of two variables</li> <li>coefficient of the generating function of many variables</li> <li>coefficient of the kth degree of the generating function</li> <li> coefficient of the kth degree of the generating function of one variable </li> <li> coefficient of the kth degree of the generating function functions of two variables </li> <li> coefficient of the kth degree of the generating function of many variables </li> <li>of the composite</li> <li>functional equation</li> <li>composition of generating functions</li> <li>composition of generating functions of one variable</li> <li>composition of generating functions of two variables</li> <li>composition of generating functions of many variables</li> <li>mutual generating function</li> <li>mutual generating function of one variable</li> <li>mutual generating function of two variables</li> <li>mutual generating function of many variables</li> <li>inverse generating function</li> <li>inverse generating function of one variable</li> <li>inverse generating function of two variables variables</li> <li>inverse generating function of many variables</li> <li>pyramid</li> <li>tensor</li> </ul> </div> <div id="6" class="article">6. Designations</div> <div class="designations"> $F(x)=\sum_{n\geqslant 0} f(n)x^n$ - an ordinary generating function (generating function) <br /> $F(x)=\sum_{n\geqslant 0} f(n)\frac{x^n}{n!}$ is an exponential generating function. <br /> $F(n,k)$ - coefficient of the kth degree of the generating function $F(x), F(0)\neq 0$<br /> $F^{\Delta}(n,k)$ - composite of the generating function $F(x), F(0)=0$<br /> $N$ - the set of natural numbers, including zero.<br /> $Z$ - a set of integers<br /> $R$ - the set of real numbers.<br /> $[x^n]F(x)$ - the operation of extracting the coefficient of the generating function $F(x)$ for a variable $x^n$.<br /> $F(x,y)=\sum_{n\geqslant 0}\sum_{m\geqslant 0} f(n,m)x^n\,x^m$ - an ordinary generating function (generating function) of two variables<br /> $[x^n\,y^m]F(x,y)$ - the operation of extracting the coefficient of the generating function $F(x,y)$ for variables $x^n$ and $y^m$.<br /> $F(n,m,k)$ - coefficient of the kth degree of the generating function $F(x,y), F(0,0)\neq 0$<br /> $F(x,y)\ldots,z)=\sum_{n\geqslant 0}\sum_{m\geqslant 0}\ldots\sum_{i \geqslant 0} f(n,m)x^n\,y^m\,\ldots z^i)$ - an ordinary generating function of many variables of variables<br /> $F^{\Delta}(n,m,k)$ - composite of the generating function $F(x,y), F(0,0)=0$<br /> ${n\choose k}$ - binomial coefficient $C_n^k$<br /> $n\brack k$ - Stirling numbers of the first kind $s(n,k)\geqslant 0$ <br /> $n \brace k $ - Stirling numbers of the second kind <br /> $\left\langle \matrix{n \cr k } \right\rangle $ - Euler numbers of the first kind <br /> $\left\langle \left\langle \matrix{n \cr k } \right\rangle \right\rangle $ - Euler numbers of the second kind <br /> $fib(n)$ - Fibonacci numbers<br /> </div> <div id="7" class="article"> 7. Obtaining explicit expressions of the composition of generating functions of one variable </div> <div> Let the generating function $G(x)=\sum_{n>0} g(n)x^n$ be given and its composite. $$ G^{\Delta}(n,k)=[x^n]G(x)^k. $$ $G^{\Delta}(0,0)=1$. Then for coefficients of the composition of generating functions $A(x)=F(G(x))$ will be the formula is valid <div class="formula"> \begin{equation}\label{Lcompos1} a(n)=\sum_{k=0}^n G^{\Delta}(n,k)\,f(k). \end{equation} <span class="formula_number">(1)</span> </div> Look at the examples </div> <div id="7_1" class="article">7.1 Fibonacci Numbers</div> <div> Find an explicit expression for the Fibonacci numbers. $$ A(x)=\frac{x}{1-x-x^2} $$ Let 's imagine the generating function as a composition $$ A(x)=F(G(x)). $$ where $F(x)=\frac{1}{1-x}$, $G(x)=x+x^2$, $f(n)=1$, $G^{\Delta}(n,k)={k\choose n-k}$ $$ a(n)=\sum_{k=0}^n {k\choose n-k} $$ </div> <div id="7_2" class="article"> 7.2 Decomposition coefficients $\sinh{\left(\frac{x}{1-x}\right)}$ </div> <div> Consider obtaining an explicit expression for the expansion coefficients $A(x)=\sinh{\left(\frac{x}{1-x}\right)}$. It is known that $$ \sinh(x)=\sum_{n>0} \frac{1-(-1)^n}{2}\frac{x^n}{n!} $$ It is also known that $$ \left(\frac{x}{1-x}\right)^k=\sum_{n\geqslant k} Tp0002(n-k,k)x^n. $$ where (See encyclopedia) $$ Tp0002(n,k)={n+k-1 \choose n}. $$ Then $$ a(n)=\sum_{k=0}^n {n-1 \choose n-k} \frac{1-(-1)^k}{2\,(k!)} $$ </div> <div id="7_3" class="article"> 7.3 Decomposition coefficients $e^{\sin(x)}$ </div> <div> To find the decomposition of the composition $A(x)=e^{\sin(x)}$ it is necessary to know composite $\sin(x)$ (in the encyclopedia it is written under the number Tp0114) $$G^{\Delta}(n,k)={\frac{(1+(-1)^{n-k})}{2^{k}\,n!} \sum_{i=0}^{\lfloor {k\over{2}}\rfloor}{(2\,i-k)^{n}{k\choose{i}}\left(-1\right)^{-i+{k+n\over(2)}}}}$$ Then $$ a(n)=\sum_{k=0}^n {\frac{(1+(-1)^{n-k})}{2^k n! k!} \sum_{i=0}^{ \lfloor {k\over{2}}\rfloor}{(2\,i-k)^{n}{k\choose{i }}(-1)^{-i+{k+n\over{2}}}}} $$ </div> <div id="7_4" class="article"> 7.4 Getting the coefficients of the function ${1-2x}\over{1-3\,x+x^2}$ </div> <div> Up0002(x)/(1-x\,Up0020(x)) Let the generating function be given $${1-2,x}\over{1-3\,x+x^2}$$ Let 's rewrite it in the form $$ \frac{x}{1-x}\frac{1}{1-\frac{x}{(1-x)^2}}+1 $$ Consider the composition of functions $A(x)=\frac{x}{(1-x)^2}$ and $\frac{1}{1-x}$ The composite of the function $A(x)$ has the expression $$ A^{\Delta}(n,k)={n+k-1\choose n-k} $$ Then $$ [x^n]\frac{1}{1-A(x)}=\sum_{k=0}^n {n+k-1\choose n-k} $$ $$ \frac{x}{1-x}\frac{1}{1-A(x)}=\frac{x}{1-x}\left(1+\frac{x}{(1-x)^2}x+\frac{x^2}{(1-x)^4}x^2+\ldots+\frac{x^n}{(1-x)^{2n}}x^n+\ldots\right)= $$ $$ =x\,\left(\frac{1}{1-x}+\frac{x}{(1-x)^3}x+\frac{x^2}{(1-x)^5}x^2+\ldots+\frac{x^n}{(1-x)^{2n+1}}x^n+\ldots\right)= $$ the series written in parentheses has odd degrees $2n+1$. From where the summation formula will have the form. $$\sum_{k=0}^{n}{n+k\choose{n-k}}$$ Taking into account shift by $x$ and plus 1 (see the original formula, we get the desired expression). $$[x^n]{1-2,x\over{1-3\,x+x^2}}=\sum_{k=0}^{n}{n+k-1\choose{2k}}$$ </div> <div id="7_5" class="article">7.5 Identity for harmonic numbers</div> <div> Let be given a generating function for harmonic numbers $$H(x)=\frac{1}{1-x}\log\left(\frac{1}{1-x}\right)$$ Consider the composition functions $H(1-e^x)$. After substitution and transformations we get $$ H(1-e^x)=-x\,e^x. $$ Knowing that the composite of the function $A(x)=e^x-1$ has the expression $$ A^{\Delta}(n,k)= {n\brace k} \frac{k!}{n!} $$ then $$ [x^n](1-e^x)^k=(-1)^k\ {n \brace k} \frac{k!}{n!} $$ From where using the formula of the composition will get $$ [x^n]H(1-e^x)=\sum_{k=0}^n (-1)^k\ {n \brace k} \frac{k!}{n!}H_k, $$ where $H_k$ - harmonic numbers. On the other hand $$ [x^n]e^{-x}(-x)=\frac{(-1)^n}{(n-1)!}. $$ Now equate the left and the right part $$ \sum_{k=0}^n (-1)^k\ {n \brace k} \frac{k!}{n!}H_k=\frac{(-1)^n}{(n-1)!} $$ Let 's make transformations and we get the identity $$ \sum_{k=0}^n (-1)^{n-k}\,k!\, {n \brace k} \,H_k=n $$ </div> <div id="8" class="article"> 8. Obtaining coefficients of degrees of generating functions of one variable </div> <div class="paragraph"> There are simple rules for calculating the coefficients of the powers of generating functions </div> <div id="8_1" class="article"> 8.1 Coefficients of the $k$th degree of the sum of generating functions </div> <div class="paragraph"> Coefficients of the $k$th degree of the sum of generating functions $$ [x^n](F(x)+G(x))^k=[x^n]\sum_{j=0}^k {k\choose j}F(x)^j\,G(x)^{k-j}= $$ <div class="formula"> \begin{equation}\label{gfsum1} \sum_{j=0}^k{k\choose j}\sum_{i=0}^n F(i,j)G(n-i,k-j) \end{equation} <span class="formula_number">(2)</span> </div> Example $$ \frac{1+x-x^3}{1-x}=\frac{1}{1-x}+x+x^2 $$ $$ [x^n]\frac{1}{(1-x)^k}={n+k-1 \choose n} $$ $$ [x^n](x+x^2)^k={k \choose n-k} $$ $$ [x^n]\left(\frac{1+x-x^3}{1-x}\right)^k=\sum_{j=0}^k \sum_{i=0}^n {i+j-1\choose i}{k-j\choose n-i-k+j} $$ </div> <div id="8_2" class="article"> 8.2 Coefficients of the $k$th degree of the product of generating functions </div> <div class="paragraph"> Coefficients $k$-th degree of the product of generating functions <div class="formula"> \begin{equation}\label{gfprod1} [x^n](F(x)\cdot G(x))^k=\sum_{j=0}^n F(i,k)G(n-i,k) \end{equation} <span class="formula_number">(3)</span> </div> Example<br /> Let the generating function $$ \frac{1+x}{1-x}=1+2\,x+2\,x^2+2\,x^3+2\,x^4+2\,x^5+\cdots $$ be given. Let's find the coefficients of the kth degree of this function using the formula (3). $$ [x^n]\left(\frac{1+x}{1-x}\right)^k=\sum_{i=0}^n {i+k-1\choose i}\,{k\choose n-i} $$ </div> <div id="8_3" class="article"> 8.3 Coefficients of the $k$th degree of the composition of generating functions </div> <div class="paragraph"> <div class="formula"> \begin{equation}\label{gfcomp1} [x^n](F(G(x))^k=\sum_{j=0}^n G^{\Delta}(n,j)F(j,k) \end{equation} <span class="formula_number">(4)</span> </div> $ G^{\Delta}(n,k)$ - - composite function of $G(x)$ <br /> Example<br /> Let the generating function $$ \frac{1}{1-sin(x)}=1+x+x^2+\frac{5x^3}{6}+\frac{2x^4}{3}+\frac{61x^5}{120}+\dots $$ be given, let's find the coefficients of the kth degree of this function using the formula (4). To do this , you need to know the composite $\sin(x)$ of the function. Her composite is recorded in the encyclopedia under the number Tp0114 (see section 7.3) $$ [x^n]\left(\frac{1}{1-\sin(x)}\right)^k=\sum_{m=0}^n Tp0114(n,m){m+k-1\choose m} $$ here $F(x)=\frac{1}{1-x}$, $G(x)=\sin(x)$. </div> <div id="8_4" class="article"> 8.4 Coefficients of the $k$th degree of the mutual generating function </div> <div class="paragraph"> <div class="formula"> \begin{equation}\label{gfrecip1} [x^n][x^n]\frac{1} {F(x)^k}=\sum_{i=0}^{n}F(0)^{-k-i}\,\left(-1\right)^{i}\,{k +i-1\choose{i}}\,F\left(n , i\right)\,{n+k\choose{n-i}} \end{equation} <span class="formula_number">(5)</span> </div> Example<br /> $$x\cot(x)=1-{\frac{x^2}{3}}-{\frac{x^4}{45}}-{\frac{2\,x^6}{945}}+\cdots $$ Let the generating function be given. Let's find the coefficients of the kth degree of this function using the formula (5). To do this , we write $$ x\cot(x)=\frac{x}{\tan(x)} $$ Let's find the composite $\tan(x)$. In the encyclopedia, this composite is written under the number $Tp0117$ $$Tp0117(n,k)=\frac{((-1)^{n}+1)}{(n+k)!}\,\sum_{j=k}^{n+k}{j-1 \choose{k-1}},j!,2^{n-j-1},(-1)^ {\frac {n+k}{2} + j} {n\brace j} $$ $$[x^n](\frac{\tan(x)}{x})^k=Tp0117(n+k,k)=\frac{((-1)^{n}+1)}{(n+k)!} \sum_{j=k}^{n+k} {j-1 \choose k-1 } j! 2^{n+k-j-1} (-1)^{\frac{n+2k}{2} +j} {n+k \brace j} $$ $$[x^n](\frac{\tan(x)}{x})^k=\frac{((-1)^{n}+1)}{(n+k)!} \sum_{j=0}^{n} {j+k-1 \choose k-1 } (j+k)! 2^{n+j-1} (-1)^{\frac{n}{2} +j} {n+k \brace j+k} $$ $$[x^n](\frac{\tan(x)}{x})^i=\frac{((-1)^{n}+1)}{(n+i)!} \sum_{j=0}^{n} {j+i-1 \choose i-1 } (j+i)! 2^{n+j-1} (-1)^{\frac{n}{2} +j} {n+i \brace j+i} $$ then the desired formula will have the expression $$ \sum_{i=0}^{n}{k+i-1\choose i}\, \frac{((-1)^{n}+1)}{(n+i)!} \sum_{j=0}^{n} {j+i-1 \choose i-1 } (j+i)! 2^{n+j-1} (-1)^{\frac{n}{2}+j+i} {n+i \brace j+i} \binom{n+k}{n-i} $$ </div> <div id="8_5" class="article"> 8.5 Finding explicit expressions for decomposing functions of the form $G(x)^{-\alpha}$, $\alpha\in R$ </div> <div class="paragraph"> <div class="formula"> $$ \sum_{j=0}^{n} \frac{(-1)^j}{T(0,1)^{j+\alpha}} {j+\alpha-1 \choose j} {T(n,j)} {n+\alpha \choose n-j} $$ <span class="formula_number">(6)</span> </div> and <div class="formula"> $$ (n+1)\binom{n+\alpha}{n+i} \sum_{i=0}^{n} \frac{T(0,1)^{-j-\alpha}(-1)^{j} T(n,j){n\choose j}} {j+\alpha} $$ <span class="formula_number">(7)</span> </div> Let's look at the examples <br /> <b class="paragraph"> 8.5.1 Example 1</b> $$ G(x)=(\frac{x}{e^x-1})^{\alpha} $$ $$ (e^x-1^k)=\sum_{n\geqslant k} {n \brace k} \frac{k!}{n!} x^n $$ $$ (\frac{e^x-1}{x})^k=\sum_{n\geqslant 0} {n+k \brace k} \frac{k!}{(n+k)!}x^n $$ $$ \sum_{j=0}^{n}(-1)^{j} \binom {j+\alpha-1}{j} {n+j \brace j} \frac{j!}{(n+j)!} { n+\alpha \choose n-j} $$ and $$ (n+1){n+\alpha \choose n+1}\sum_{j=0}^{n} \frac{(-1)^{j}j! {n+j\brace j} {n \choose j}} {(j+\alpha)(n+j)!} $$ <b class="paragraph"> 8.5.2 Example 2</b> $$ G(x)=(\sqrt{\cos(x)})^{3} $$ For the function $cos(x)$, the expression $cos(x)^k$ expansion coefficient is known. In the encyclopedia under the number Tp0115. $$ Tp0115(n,k)= \begin{array} 11, & n=0, \ \frac{(-1)^{n \over 2} {(-1)^{n}+1}} {2^{k} n!} \sum\limits_{i=0}^{k-1 \over 2} (k-2i)^{n} {k\choose i} & n>0.\ \end{array} $$ Let 's use the formula (6) for $\alpha=-\frac{3}{2}$, $Tp0115(0,1)=1$ $$ \sum_{j=0}^{n}(-1)^{j} \binom{j-\frac{3}{2}-1}{j} Tp0115(n,j) \binom{n-\frac{3}{2}}{n-j} $$ </div> <div id="8_6" class="article"> 8.6 Coefficients of the $k$th degree of the generating function of the solution of the functional equation $A(x)=G(x\,A(x)^m$, $m\in N$ </div> <div class="paragraph"> Let the functional equation $A(x)=G(x\,A(x)^m$, $m\in N$ be given and the expression $$ [x^n]G(x)^k=G(n,k) $$ $G(0)\ne 0$ is known. Then for the coefficients of the degree: $$ [x^n]A(x)^k=A(n,k) $$ the following relation holds <div class="formula"> \begin{equation}\label{gflagr1} A(n,k)=\frac{k}{m\,n+k}G(n,m\,n+k) \end{equation} <span class="formula_number">(8)</span> </div> Example Let the functional equation $$ A(x)=\frac{1+x\,A(x)}{1-x\,A(x)} $$ $m=1$ be given. To solve this equation, it is necessary to find $G(n,k)$. It is known (see the example section 8.2) that $$ [x^n]\left(\frac{1+x}{1-x}\right)^k=\sum_{i=0}^n {i+k-1\choose i}\,{k\choose n-i} $$ Substituting the found $G(n,k)$ into the formula (8) we will get the desired solution $$ A(n,k)=\frac{k}{n+k}\sum_{i=0}^n {n+k+i-1\choose i}\,{n+k\choose n-i} $$ Now let 's rewrite our equation in the form $$ x\,A(x)^2+1+(x-1)\,A(x)+1=0 $$ we solve it with respect to $A(x)$, we get $$ A(x)={1-x+\sqrt{1-6\,x+x^2}\over{2\,x}}$$ Then $$[x^n]\left({1-x+\sqrt{1-6\,x+x^2} \over{2\,x}}\right)^k=\frac{k}{n+k}\sum_{i=0}^n {n+k+i-1\choose i}\,{n+k\choose n-i}.$$ thus, the formula of the coefficients of the degree for the generating function of large Schroeder numbers is found (see encyclopedia) </div> <div id="8_7" class="article"> 8.7 Coefficients of the $k$th degree of the inverse generating function </div> <div class="paragraph"> Consider the functional equation $$ A(x)\cdot G(A(x))=x $$ $G(0)\ne 0.$ $$ G^{\Delta}(n,k)=[x^n]\left(x\,G(x)\right)^k. $$ Then <div class="formula"> \begin{equation}\label{gfinver1} A^{\Delta}(n,k)=\frac{k}{n}\sum_{j=0}^{n-k} G(1,1)^{-n-j}(-1)^{j} {n+j-1\choose j}G^{\Delta}(n,j) {2\,n-k \choose n-k-j} \end{equation} <span class="formula_number">(9)</span> </div> Example Let the generating function be given: $$ G(x)=\frac{\exp(x)+x-1}{2} $$ We obtain the coefficients of the k-degree of the inverse function. To do this, use the formula (9). Find the composite of the function $G(x)$,to do this, use the sum formula: $B(x)=e^x-1$, its composite ${n\choose k}\frac{k!}{n!}$. For $C(x)=x$, composite $\delta(n,k)$. Then $$ G^{\Delta}(n,k)=\sum_{j=0}^k{k\choose j}\sum_{i=0}^n {i \brace j}\frac{j!}{i!}\delta(n-i,k-j) $$ Now substitute $i=n-k+j$ $$ G^{\Delta}(n,k)=\sum_{j=0}^k{k\choose j} {n-k+j\brace j} \frac{j!}{(n-k+j)!} $$ $$ $G^{\Delta}(1,1)=1,$$ $$ A^{\Delta}(n,k)= \frac{k}{n}\sum_{j=0}^{n-k}(-1)^{j}\,{n+j-1\choose j}G{\Delta}(n,j) {2\,n-k \choose n-k-j} $$ From where we get the identity $$\sum_{j=k}^{n}{A^{\Delta}(j,k)\,G^{\Delta}(n,j)}=\delta(n,k)$$ </div> <div id="8_8" class="article"> 8.8 Coefficients of the kth degree of the generating function of the solution of the functional equation $A(x)=G\left(\frac{x}{A(x)}\right)$ </div> <div> <div class="formula"> \begin{equation}\label{gfleft1} A(n,k)=k\,\sum_{j=1}^{n}\frac{1}{j}{G}\left(0 , 1\right)^{-n+k-j}\left(-1 \right)^{j-1}{G}\left(n , j\right){n-k+j-1 \choose j-1}{2\,n-k \choose n-j} \end{equation} <span class="formula_number">(10)</span> </div> ${\bf Example}$ Let $$ G(x)=\frac{\log(1+x)}{x} $$ and $$$ G(n,k)=\frac{k!}{(n+k)!}{n+k \brack k}(-1)^n. $$ Let 's write down the equation $$ A(x)=G\left(\frac{x}{A(x)}\right)=\frac{\log(1+\frac{x}{A(x)}}{\frac{x}{A(x)}} $$ From where, we get the generating function for the Bernoulli numbers $$ A(x)=\frac{x}{e^x-1} $$ Then $$ A(n,k)=k\,\sum_{j=1}^{n}\frac{1}{j} {\left(-1\right)^(n+j-1)}\frac{j!}{(n+j)!} {n+j \brack j}{n-k+j-1\choose j-1} {2,n-k \choose n-j} $$ $A(0,k)=1$ </div> \s <div id="8_9" class="article"> 8.9 Generating function for the diagonal $G(n,n)$ </div> <div> Let the generating function $G(x)=\sum_{n\geqslant 0} g(n)x^n$be given and the coefficients of expansion of its degree $$ G(n,k)=[x^n]G(x)^k $$ Then the generating function for the diagonal $G(n,n)$ will have an expression $$ \frac{x\,A'(x)}{A(x)}, $$ where $A(x)$ is the solution of the functional equation $$ A(x)=G(x\,A(x)). $$ If $A(n,k)$ is known, then the diagonal $G(n,n)$ will have the following expression <div class="formula"> $\begin{equation} G(n,n)=n\,\sum_{j=1}^{n}\frac{(-1)^{j-1}\,A(n,j)}{j\,A(0,1)^{j}}\,{n\choose j}. \end{equation}$ <span class="formula_number">(11)</span> </div> Example. Let the generating function $$ G(x)=\frac{1+x-x^2}{1-x} $$ be given and the expression for the coefficients of the degree is given $$ [x^n]G(x)^k=G(n,k)=\sum_{j=0}^{\left \lfloor {n \over 2} \right \rfloor}{k \choose j}\,{n-j-1\choose n-2\,j} $$ It is necessary to find the generating function for the diagonal $G(n,n)$. To do this , you need to solve the equation $$ A(x)=G(x\,A(x)=\frac{1+x\,A(x)-x^2\,A(x)^2}{1-A(x)} $$ $$A(x)^2\,\left(x^2+x\right)+A(x),\left(-x-1\right)+1=0$$ $$A(x)=1+x-\sqrt {1-2x-3x^2}\over{2\,x+2\,x^2}$$ We find the logarithmic derivative $$B(x)=\frac{(xA(x))'}{A(x)}\frac{1}{2} ({1\over 1+x}+{1\over\sqrt{1-2x-3x^2}}) $$ from where $$ [x^n]B(x)=G(n,n)=\sum_{j=0}^{\left \lfloor {n \over 2 } \right \rfloor}{n \choose j}\,{n-j-1 \choose n-2\,j} $$ </div> <div id="8_10" class="article"> 8.10 Decomposition of the composition $F(x)=\log(A(x))$ </div> <div> The consequence of the statements of the paragraph 8.9 is that for the composition of the functions of $F(x)=\log(A(x))$, the expansion coefficients will have the expression <div class="formula"> \begin{equation}\label{gflog1} f(n)=\sum_{j=1}^{n}\frac{(-1)^{j-1}\,A(n,j)}{j\,A(0,1)^{j}}\,{n\choose j}. \end{equation} <span class="formula_number">(12)</span> </div> Let's look at the examples<br /> Example 1 $$ \log\left(\frac{1}{1-x}\right) $$ $$ [x^n]\left(\frac{1}{1-x}\right)^k={n+k-1\choose n} $$ $$\sum_{j=1}^{n}\frac{(-1)^{j-1}}{j}{n+j-1\choose n}{n \choose j}=\frac{1}{n}$$ Example 2 $$\log(e^x)=x$$ $$\sum_{j=1}^{n} (-1)^{j-1}\,{n\choose j}j^{n-1}=\left\{\begin{array}{ll} 1,& n=1,\ 0,& n>0. \end{array}\right.$$ </div> <div id="9" class="article"> 9. Obtaining explicit expressions of the composition of generating functions of two variables </div> <div class="paragraph"> Consider the solution of the problem of finding an explicit formula for the composition of generating functions of two variables. To do this, write down Table 1 obtained in <a href="#18" class="ref_link">[3]</a>. In the first column, the variants of the composition of the generating functions are written, in the second - explicit expressions of the coefficients of the $k$-th degree of the generating function, the expression through the coefficients of the $k$-th degree of the generating functions forming the composition. For $k=1$ we obtain the coefficients of the composition of the generating functions. </div> <div> <table border="1" class="table"> <caption> Table of formulas for determining coefficients of degrees of series composition </caption> <tr> <th>N</th> <th>Composition $G(x,y)^k$</th> <th>The formula for $g(n,m,k)$</th> </tr> <tr> <td>1</td> <td>$G(x,y)^k=H(A(x),y)^k$</td> <td>$g(n,m,k)=\sum\limits_{q=0}^n A^{\Delta}(n,q)h(q,m,k)$</td> </tr> <tr> <td>2</td> <td>$G(x,y)^k=H(x,B(y))^k$</td> <td>$g(n,m,k)=\sum\limits_{r=0}^m B^{\Delta}(m,r)h(n,r,k)$</td> </tr> <tr> <td>3</td> <td>$G(x,y)^k=H(A(x,y))^k$</td> <td>$g(n,m,k)=\sum\limits_{q=0}^{n+m} A^{\Delta}(n,m,q)h(q,k)$</td> </tr> <tr> <td>4</td> <td>$G(x,y)^k=H(A(x,y),y)^k$</td> <td> $g(n,m,k)=\sum\limits_{q=0}^{n+m}\sum\limits_{r=0}^{m}{A^{\Delta}\left(n ,m-r,q\right)h(q,r,k)}$ </td> </tr> <tr> <td>5</td> <td>$G(x,y)^k=H(x,B(x,y))^k$</td> <td> $g(n,m,k)=\sum\limits_{q=0}^{n}{\sum\limits_{r=0}^{n+m-q}{B^{\Delta}\left(n-q ,m,r\right)}\,h(q,r,k)}$ </td> </tr> <tr> <td>7</td> <td>$G(x)^k=H(x,B(x))^k$</td> <td> $g(n,k)=\\sum\\limits_{q=0}^{n}{\\sum\\limits_{r=0}^{n-q}{B^{\\Delta}(n-q,r)\, h(q,r,k)}}$ </td> </tr> </table> <div class="paragraph"> To perform a composition $G(x,y)=H(A(x,y),y)$ it is necessary to know the condition that the internal function $A(0,0)=0$. In the developed knowledge base there are many functions having a free member $A(0,0)\
e=0$. To achieve a given condition , you can use the following methods : multiplying the generating function by a monomial variable $x^ay^b$, where $a,b \in N$, $a\geqslant 0$, $b\geqslant 0$ or by subtracting from the generating function of the zero element of the decomposition. </div> $$G(x,y)={x,y-1\over{x,y+x^2+x-1}}$$ it can be represented as $$ G(x,y)=\frac{1}{1-\frac{x+x^2}{1-x\,y}}=H(A(x,y)), $$ where $H(x)=\frac{1}{1-x}$, $A(x,y)=\frac{x+x^2}{1-x\,y}$ In the knowledge base we do request for a generating function $U(x,y)=\frac{1+x}{1-y}$. We will get the pyramid found at number 17. <div class="fragment"> Generating function: <br /> $U_{17}(x,y)={1+x\over{1-y}}$ <br /> Formula: $T_{17}(n,m,k)={k\choose{n}}\,{m+k-1\choose{m}}$ <br /> Data: <br /> $\begin{array}{lllllll}1&1&1&1&1&1&1\\1&1&1&1&1&1&1\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0 \end{array} $ </div> Then the formula $x\frac{1+x}{1-y}$ will be true for the composites of the function $$ T_{17}(n-k,m,k)={k\choose{n-k}}\,{m+k-1\choose{m}} $$ Now let's do let's do the product of the variable $y$ by $x$ we get $$ A^{\Delta}(n,m,k)=T_{17}(n-m-k,m,k)={k\choose{n-k}}\,{m+k-1\choose{m}} $$ From where, based on the formula of the composition of two variables (see Table 1, line 3, $k=1$) $$ g(n,m)=\sum_{k=0}^{n+m} A^{\Delta}(n,m,k)=\sum_{k=0}^{n-m}{k\choose{n-m-k}}\,{m+k-1\choose{m}}. $$ Thus, we have obtained an explicit formula for the triangle sequence A055830, describing the class of paths on the lattice <a href="#18" class="ref_link">[12]</a>. </div> <div id="10" class="article">10. Finding mutual generating functions</div> <div> Let be given a generating function of the form: $$G(x,y)={x-\sqrt{x^2-2\,x^2\,y+2\,\sqrt{1-4\,x}\,x^2\,y}}\over{2\,x^2\,y}$$ Let 's find an explicit formula for the mutual generating function: $$ A(x,y)=\frac{1}{G(x,y)} $$ Decompose the function $G(x,y)$ nto a Taylor series at the point $x=0$ and $y=0$ $$ \begin{array}{l}\ 1\ +\left(1+y+\cdots \right)\,x\ +\left(2+2\,y+2\,y^2+\cdots \right)\,x^2\ +\left(5+5\,y+6\,y^2+5\,y^3+\cdots \right)\,x^3\ +\left(14+14\,y+18\,y^2+20\,y^3+14\,y^4+\cdots \right)\,x^4+\cdots \end{array}$$ Note that this function describes a triangle and $G(0,0)=1$. Then we write the function $H\left(x,\frac{y}{x}\right)$. Looking for this function in the knowledge base, we get the function and tensor number 69 (see paragraph 10) <div class="fragment"> Generating function: <br /> $U_{69}(x,y)=x-\sqrt{x^2-2\,x\,y+2,\sqrt{1-4\,x}\,x\,y}\over{2\,x\,y}$ <br /> Formula: $T_{69}(n,m,k)=\frac{k\,{2\,m+k-1 \choose{m}}\, {2\,n+m+k-1\choose{n}}}{n+m+k}$ <br /> Data: <br /> $\begin{array}{lllllll}1&1&2&5&14&42&132\\1&2&6&20&70&252&924 \\2&5&18&70&280&1134&4620\\5&14&56&240&1050&4620&20328 \\14&42&180&825&3850&18018&84084\\42&132&594&2860&14014&68796&336336 \\132&429&2002&10010&50960&259896&1319472\end{array}$ </div> Then the expression will be true for the original function: $$ G(x,y)=\sum_{n}\sum_{m} T_{69}(n-m,m,k)x^n\,y^m. $$ To obtain an expression of the coefficients of the mutual generating function, you can use the expression[10]: $$T_r(n,m,k)=\sum_{j=0}^{m+n}{T(0 , 0 , 1)^{-j-k}(-1)^{j}{j+k-1\choose{j}}{\it T}\left(n , m , j\right) {k+m+n\choose{m+n-j}}}$$ Where $T(n,m,k)$ - is the tensor for the original generating function, provided that $T(0,0,0)=1$ and $T(n,m,0)=0$. Write down the tensor for the original function $$ T(n,m,k)=T_{69}(n-m,m,k)={\frac{k}{n+k}{2\,m+k-1\choose{m}}{2\,n+k-1\choose{n-m}}}. $$ Then the tensor of the mutual generating function will have an explicit expression $$ T_r(n,m,k)=\sum_{j=0}^{m+n}(-1)^{j} {j+k-1\choose{j}} {\frac{j}{n+j}} {2\,m+j-1\choose{m}} {2\,n+j-1\choose{n-m}} {k+m+n\choose{m+n-j}}. $$ </div> <div id="10_1" class="article"> 10.1 Finding explicit expressions for decomposing functions of the form $G(x,y)^{\alpha}$ </div> <div> Let $$ G(x,y)^k=\sum_{n\geqslant 0}\sum_{m\geqslant 0} T(n,m,k)x^ny^m $$ $G(0,0)\neq 0$.Then the coefficients of the decomposition of the function $$ \frac{1}{G(x,y)^{\alpha}} $$ will have the following expressions <div class="formula"> \begin{equation} \sum_{j=0}^{n+m}{\frac{(-1)^{j}} {T(0,0,1)^{j+\alpha}} {j+\alpha-1\choose{j}}{\it T}(n,m,j) {n+m+\alpha \choose{n+m-j}}} \end{equation} <span class="formula_number">(13)</span> </div> and <div class="formula"> \begin{equation} (n+m+1){n+m+\alpha\choose{n+m+1}}\sum_{j=0}^{n} T(0,0,1)^{-j-\alpha} (-1)^{j} T(n,m,j) {n+m\choose{j}} \over{j+\alpha} \end{equation} <span class="formula_number">(14)</span> </div> Let's look at the example $$ \frac{x+y}{\log(1+x+y)} $$ $$ (\log(1+x)^k=\sum_{n\geqslant k} (-1)^{n-k}{n \brack k} \frac{k!}{n!}\,x^n $$ $$ \left(\frac{\log(1+x)}{x}\right)^k=\sum_{n\geqslant 0} (-1)^n\, {n+k \brack k} \frac{k!}{(n+k)!}x^n $$ Let's find the composition $$ A(B(x,y))=\frac{\log(1+x+y)}{x+y} $$ where $A(x)=\log(1+x)$, $B(x,y)=x+y$. Let's find the function $B(x,y)$ in the encyclopedia.This function is written by number 0001. Where from $$ B(x,y)^k= \sum_{n\geqslant 0} \sum_{m \geqslant 0} \delta_{k, n+m}\, {n+m \choose m }\,x^n\,y^m $$ Then we use the formula compositions (see table). We get $$ \sum_{j=0}^{n+m} B^{\Delta}(n,m,k)A^{\Delta}(j,k)= $$ $$ \sum_{j=0}^{n+m} \delta_{j, n+m} \,{n+m \choose m }(-1)^j\,{j+k \brack k}\frac{k!}{(j+k)!}= $$ $$ {n+m \choose m}(-1)^{n+m} {n+m+k \brack k} \frac{k!}{(n+m+k)!} $$ $$ \sum_{j=0}^{n+m} {\left(-1\right)^{j}\,}\ { j+\alpha-1 \choose j} {n+m \choose m} (-1)^{n+m} {n+m+j \brack j} \frac{j!}{(n+m+j)!}\, {n+m+\alpha \choose n+m-j} $$ </div> <div id="11" class="article"> 11. Finding the coefficients of inverse generating functions </div> <div> Let the generating function $$ F(x,y)=\frac{x}{1-x-x^2(1+y)} $$ be given. Find the coefficients of the expansion of the inverse function satisfying the equation $$ G(A(x,y),y)=x . $$ To do this , we write $$ G_x(x,y)=\frac{G_x(x,y)}{x}. $$ Then the equation will take the form: $$ A(x,y)=\frac{x}{G_x(A(x,y),y)} $$ Now let's perform the substitution $A(x,y)=xA_x(x,y)$ $$ A_x(x,y)=\frac{x}{G_x(A_x(x,y),y)} $$ Then to find the inverse of the functions, you can use the formula. However, in this case the mutual mutual function is easy to find $$ G_{r}(x,y)=1-x-x^2(1+y)=(1-x(1+x+xy). $$ Now we find the pyramid $T(n,m,k)$ of the function $F(x,y)=(1+x+xy)$ at number 37 (see the fragment below). <div class="fragment"> Generating function:<br /> $U_{37}(x,y)=1+x+x\,y$ <br /> Formula: $T_{37}(n,m,k)={k\choose{n}}\,{n\choose{m}}$ Data: $\begin{array}{lllllll}1&0&0&0&0&0&0\\1&1&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\end{array}$ </div> $$ T_r(n,m,k)=\sum_{i=0}^{n+m} T_{37}(n-i,m,i){k\choose i}(-1)^i=\sum_{i=0}^{n+m} {i\choose{n-i}}\,{n-i\choose{m}}{k\choose i}(-1)^i= $$ $$ \sum_{i=0}^{n} {i\choose{n-i}}\,{n-i\choose{m}}{k\choose i}(-1)^i $$ Then the coefficients for $A_x(x,y)^k$ $$ T_{A_x}(n,m,k)=\frac{k}{n+k}T_r(n,m,n+k)=\frac{k}{n+k}\sum_{i=0}^{n} {i\choose{n-i}}\,{n-i\choose{m}}{k+n\choose i}(-1)^i $$ $${\sqrt{4\,x^2\,y+5\,x^2+2\,x+1}-x-1}\over{2\,x^2\,y+2\,x^2}$$ </div> <div id="12" class="article"> 12. Finding the generating function for the explicit expression of coefficients </div> <div> Let the expression be given $$\sum_{k=0}^{m}{n+m-k+2\choose{k}}{n+m-k\choose{n}}$$ We will perform a number of transformations in order to obtain one of the compositional formulas presented in <a href="#18" class="ref_link">[3]</a>. $$\sum_{k=0}^{m}{n+m-k+2\choose{ k}}{m-k+n\choose{n}}$$ changing the summation order from $k$ to $m-k$ $$\sum_{k=0}^{m}{n+k+2\choose{ m-k}}{k+n\choose{n}}$$ now the index $k$ does not start from zero, but from $n$ $$\sum_{k=n}^{n+m}{k+2\choose{ n+m-k}}{k\choose{n}}$$ now the index k $k$ starts from zero. $$\sum_{k=0}^{n+m}{k+2\choose{ n+m-k}}\,{k\choose{k-n}}$$ we introduce a new variable and introduce summation by this variable, using the kronecker symbol $$ j=n+m-k $$ we get $$\sum_{k=0}^{n+m}{\sum_{j=0}^{m}{\delta_{j, n+m-k} \,{k+2\choose{ j}}\,{-j+n+m\choose{m-j}}}}$$ now we compare it with the compositional formula $$g(n,m)=\sum\limits_{k=0}^{n+m}\sum\limits_{j=0}^{m}{A^{\Delta}\left(n ,m-j,k\right)h(k,j)}$$ Note that for our case $$ A^{\Delta}\left(n ,m-j,k\right)={\delta_{j, n+m-k}{-j+n+m\choose{m-j}}} $$ Where from $$ A^{\Delta}(n ,m,k)={\delta_{k, n+m}{n+m\choose{m}}} $$ From where, using the encyclopedia, we will find the pyramid at number 1, its generating function is $(x+y)$. Now let's find the generating function for $$ h(n,m)={n+2\choose{ m}} $$ We make a request to the knowledge base: $T=binomial(n+2,m)$ We get the pyramid number 42 (see the fragment below). <div class="fragment"> Generating function: <br /> $U_{42}(x,y)=\frac{(1+y)^2}{1-x\,(1+y)}$ Formula: <br /> $T_{42}(n,m,k)={n+k-1\choose{n}}\,{n+2k\choose{m}}$ Data: $\begin{array}{lllllll}1&2&1&0&0&0&0\\1&3&3&1&0&0&0\\1&4&6&4&1&0&0\\1&5&10&10&5&1&0\\1&6&15&20&15&6&1\\1&7&21&35&35&21&7\\1&8&28&56&70&56&28\end{array}$ </div> From where we get the desired generating function. $$ A(x,y)=UU0042(x+y,y)= {\left(y+1\right)^2 \over 1-\left(y+1\right)\,\left(y+x\right)} $$ </div> <div id="13" class="article"> 13. Finding the composition of logarithmic functions and their derivatives </div> <div> 1. Let be given a functional equation of the form: $$ A(x,y)=G(x\,A(x,y),y) $$ And the expression of the coefficients of the k-degree of the generating function $G(x,y)$. $$ T_G(n,m,k)=[x^n\,y^m]G(x,y)^k. $$ is known. Then the coefficients of the logarithmic partial derivative of the generating function $A(x,y)$ in $x$ , will be expressed in terms of the coefficients $T_G(n,m,k)$ $$ T_{lx}(n,m)=[x^n\,y^m]\frac{1}{A(x,y)}\frac{\partial A(x,y)}{\partial x} $$ $$ T_{lx}(n,m)=T_G(n,m,n) $$ 2.Let a functional equation of the form be given: $$ A(x,y)=G(x,y\,A(x,y)) $$. And the expression of the coefficients of the k-degree of the generating function is known $G(x,y)$. $$ T_G(n,m,k)=[x^n\,y^m]G(x,y)^k. $$ then the coefficients of the logarithmic partial derivative of the generating function $A(x,y)$ in $y$ , will be expressed in terms of the coefficients $T_G(n,m,k)$ $$ T_{ly}(n,m)=[x^n\,y^m]\frac{1}{A(x,y)}\frac{\partial A(x,y)}{\partial y} $$ $$ T_{ly}(n,m)=T_G(n,m,m) $$ Let's find the coefficients of the logarithmic derivative of the generating function $A_{139}(x,y)$ of the corresponding frame in the knowledge base shown in the fragment below: <div class="fragment"> Generating function:<br /> $U_{139}(x,y)=\frac{1-2\,x-y-\sqrt{1-4\,x-(2-4\,x)\,y+y^2}}{2\,x^2}$ Formula:<br /> $T_{139}(n,m,k)={k\,{n+m+k\choose{m}}{2n+2k\choose{n}}\over{n+m+k}}$ Data: $\begin{array}{lllllll}1&1&1&1&1&1&1\\2&4&6&8&10&12&14\\5&15&30&50&75&105&140\\14&56&140&280&490&784&1176\\42&210&630&1470&2940&5292&8820\\132&792&2772&7392&16632&33264&60984\\429&3003&12012&36036&90090&198198&396396\end{array}$ <br /> Right on y: UU0138(x,y)<br /> Left on x: UU0059(x,y)<br /> Left on y: UU0060(x,y)<br /> Change x y: UU0359(x,y)<br /> </div> Next, follow the link to the frame 59 and copy the explicit formula for the tensor of the generating function UU0059(x,y). $$ T_{59}(n,m,k)=\frac{k {\binom{2 k}{n}} {\binom{k + m}{m}}}{k + m} $$ For the desired logarithmic derivative $$ G(x,y)=\frac{1}{A(x,y)}\frac{\partial A(x,y)}{\partial x}= 1-2\,x^2-{2\,x^2\over{U(x\,y)}}+{x^2\,(4-4\,y)\over{2{\it U}\left(x , y\right)\,\sqrt{1-4\,x-\left(2-4\,x\right)\,y+y^2}}}, $$ where $$ U(x,y)=1-2\,x-y-\sqrt{1-4\,x-\left(2-4\,x\right)\,y+y^2}. $$ the coefficients will have an explicit expression $$ g(n,m)=T_{59}(n,m,n)={n\,{2\,n\choose{n}}\,{m+n\choose{m}}\over{m+n}}=\binom{2n}{n}\binom{n+m-1}{m}. $$ 3. Consider the case when the left tensor for this generating function is unknown, but there is a tensor of this function. Then you can use the following formulas. The formula for the partial logarithmic derivative of $x$ variable is as follows: $$ T_{logx}(n,m)=\left\{\begin{array}{ll}\ T(0,0,1)^n & n=0\;, m=0,\ n\,\sum_{j=1}^{n+m}{(-1)^{j-1}\,T(n,m,j)\,{n+m\choose{j}} \over{T^{j}(0 , 0 , 1)j}}, & n>0\;or\; m>0.\ \end{array} \right. $$ The formula for the partial logarithmic derivative of $x$ variable is as follows: $$ T_{logy}(n,m)=\left\{\begin{array}{ll}\ T(0,0,1)^m & n=0\;, m=0,\ m\, \sum_{j=1}^{n+m}{(-1)^{j-1}\, T(n , m , j){n+m\choose{j}}} \over{T^{j}(0 , 0 , 1)\,j}, & n>0\;or\; m>0.\ \end{array} \right. $$ Comparing the above formulas for partial logarithmic derivatives, you can see that they differ by multipliers $m$ and $n$. The terms $T_{logx}(n,m)$ and $T_{logy}(n,m)$ describe the decomposition of the logarithmic derivative if the terms $T_{logx}(n,m)$ by $n$, and $T_{logy}(n,m)$ by $m$, we obtain the terms of the decomposition of the composition of generating functions $$ log(U(x,y)), $$ where $U(x,y)$- is the generating function having the tensor $T(n,m,k)$.Let 's write down an explicit formula for the members of the composition $$ Lo(n,m)=\sum_{j=1}^{n+m}{(-1)^{j-1} T(n , m , j){n+m\choose{j}} \over{T^{j}(0 , 0 , 1)j}} $$ Consider an example. Let the generating function number 130 be given. <div class="fragment"> Generating function: $$U_{130}(x,y)={1\over-4\,y+(1-x+y)^2}$$ Formula: $$T_{130}(n,m,k)={m+k\choose{k-1}}{n+k-1\choose{k-1}}{n+m+2\,k-1\choose{ k-1}}{2\,(n+m)+2\,k\choose{2\,m+1}}\over{2\,{2\,k-2 \choose{k-1}}{2m+2\,k\choose{2\,k-2}}}$$ Data: $$\begin{array}{lllllll}1&2&3&4&5&6&7\\2&10&28&60&110&182&280\\3&28&126&396&1001&2184&4284\\4&60&396&1716&5720&15912&38760\\5&110&1001&5720&24310&83980&248710\\6&182&2184&15912&83980&352716&1248072\\7&280&4284&38760&248710&1248072&5200300\end{array}$$ </div> Then the coefficients of the decomposition of the composition of functions $$ \log(UU_{130}(x,y)=\log({1\over{-4\,y+(1-x+y)^2}}) $$ $$ Lo(n,m)=\sum_{k=1}^{n+m} (-1)^{k-1} { {m+k\choose{k-1}} {n+k-1\choose{k-1}} {n+m+2\,k-1\choose{k-1}} {2\,(n+m)+2\,k\choose{2\,m+1}} \over 2\,k\,{2\,k-2\choose{k-1}}\,{2\,m+2\,k\choose{2\,k-2}} } {n+m\choose{k}} $$ </div> <div id="14" class="article">14.Examples</div> <div id="14_1" class="article">14.1 Example 1. Fina Triangle</div> <div> Consider the generating function for the Fin triangle $$ G(x,y)={2\over{1+\sqrt{1-4\,x}+2\,x-2\,x\,y}} $$ $$G(x,y)=\frac{A(x)}{1-y\,A(x)}.$$ $$A(x)=\frac{2}{1+\sqrt{1-4\,x}+2\,x}$$ $$ G(x,y)=A(x)\,y+A(x)^2\,y^2+\ldots+A(x)^n\,y^n+\ldots $$ $A(x)$ - s the generating function of the Fin sequence (see. $Up0157(x)$). Then $$ G(x,y)=\sum_{n\geqslant k} Tp0157(n,k)\,x^n\,y^k $$ </div> <div id="14_2" class="article"> 14.2 Example 2. Euler triangle (Euler numbers of the first genus) </div> <div> Generating function for Euler numbers of the first genus $$E(x,y)={y-1\over{y-e^{x(y-1)}}}$$ Let 's imagine it in the form $$E(x,y)={1\over{1-\frac{e^{x,(y-1)}-1}{y-1}}}$$ Consider the function $$ A(x,y)=\frac{e^{x(y-1)}-1}{y-1} $$ Then it can be represented by a composition of functions $$ A(x,y)=x\,B(C(x,y)), $$ where $B(x)=\frac{e^x-1}{x}$ and $C(x,y)=x\,(y-1)$. Then $B(x)=Up0102(x)/x$ $$ B(x)^k=(\frac{e^x-1}{x})^k=\sum_{n\geqslant 0} Tp0102(n+k,k)x^n. $$ where $$Tp0102(n,k)=\frac{k!}{n!}\,{n \brace k}$$ Using the encyclopedia we will find $C(x)^k$ $$ C(x)^k=\sum_{n\geqslant k}\,Tuu0002(n,m,k)\,(-1)^{m+k}\,x^n\,y^m $$ $$ Tuu0002(n,m,k)=\delta_{k, n} \,{n\choose m} $$ We find the coefficients $B(C(x))^k$ $$ \sum_{j=0}^{n+m} Tuu0002(n,m,j)(-1)^{m+j}Tp0102(j+k,k)= $$ $$ \sum_{j=0}^{n+m}\delta_{j, n} \,{n\choose m}(-1)^{m+j}\frac{k!}{(j+k)!}\,{j+k \brace k}= $$ $$ {n \choose m }(-1)^{n+m}\frac{k!}{(n+k)!}\,{n+k \brace k}. $$ We find the coefficients $x\,B(C(x))^k$ $$ {n-k\choose m }(-1)^{n+m-k}\frac{k!}{n!}\,{n \brace k}= $$ From where we find an explicit expression for the decomposition coefficients of the desired composition $$ \sum_{k=0}^{n} {n-k\choose m}(-1)^{n+m-k}\frac{k!}{n!}\,{n \brace k} $$ Then Euler numbers of the first kind will have the following explicit expression $$ {\left\langle \matrix{n\cr m} \right\rangle}=\sum_{k=0}^{n-m} (-1)^{n+m-k}\,k!\,{n-k \choose m} {n \brace k} $$ </div> <div id="14_3" class="article"> 14.3 Example 3. Generating function for second-order Euler numbers </div> <div> Consider the use of an encyclopedia to obtain a generating function for Euler numbers of the second genus. To do this, we prove the following theorem. <br /> <b>Theorem 2</b> The exponential generating function for second-order Euler numbers has the form: <div class="formula"> $$ \sum\limits_{n \geqslant 0} \sum_{m\geqslant \geqslant0} {\left\langle \left\langle \matrix{n\cr m} \right\rangle \right\rangle} \frac{x^n}{n!}t^m={1-t\over{W(-t e^{(1-t)^2,x-t})+1}}, $$ <span class="formula_number">(15)</span> </div> where $W(x)$ -is the Lambert function, $x>0$. <br /> <b> Proof </b>We write down the exponential generating function in the form of a double series, while taking the offset by $(n-1)$ $$ E(x,t) = \sum_{n>0}\sum_{m>0} {\left\langle \left\langle \matrix{n-1\cr m} \right\rangle \right\rangle} \frac{x^n}{n!}t^m $$ Consider the formula obtained in <a href="#18" class="ref_link">[15]</a> <div class="formula"> $$ {\left\langle \left\langle \matrix{n\cr m} \right\rangle \right\rangle} =\sum_{k=0}^m (-1)^{m-k}\,{2\,n+1 \choose m-k} {n+k \choose k}, $$ <span class="formula_number">(16)</span> </div> It can be represented as the product of two rows $$ E(x,t)=\sum_{n>0}P_n(t)\frac{x^n}{n!}\,(1-t)^{2n-1} $$ where $$ (1-t)^{2\,n-1}=\sum_{n\geqslant 0}(-1)^m\,{2\,n-1 \choose m}t^m $$ and $$ P_n(t)=\sum_{m\geqslant 0}{n+m-1 \brace m}t^m $$ Let 's write the function $$ u(x,t)=\sum_{n>0}\sum_{m\geqslant 0}{n+m-1 \brace m}\frac{x^n}{n!}t^m $$ We show that this function is the inverse function for the function $$ y(x,t)=(x-t(e^x-1)). $$ let 's write a mutual function for $y(x,t)$ $$ \frac{x}{y(x,t)}=\frac{1}{1-t\frac{e^x-1}{x}} $$ and find her degree. To do this , we write $$ (t(\frac{e^x-1}{x}))^k=\sum_{n>0} \sum_{m>0}T(n,m,k)x^nt^n $$ It is known that for the function $(e^x-1)$ is available identity $$ (e^x-1)^k=\sum\limits_{n\geqslant 0} k!{n \brace k}\frac{x^n}{n!}, $$ we get $$ T(n,m,k)=\delta(m,k){n+k \brace k}\frac{k!}{(n+k)!}, $$ where $\delta(m,k)$ is the Kronecker symbol. For the function $\frac{1}{(1-x)}$ the identity is known $$ \frac{1}{(1-x)^k}=\sum_{n\geqslant 0} {n+k-1 \choose n}x^n. $$ Then for the degree of composition of two generating functions $$ ({1 \over 1-t\frac{e^x-1}{x}})^k =\sum\limits_{n\geqslant 0} \sum\limits_{m\geqslant 0} D(n,m,k)x^nt^m, $$ based on the compositional formula \cite{kru}, we can write $$ D(n,m,k)=\sum\limits_{i=0}^{n+m} T(n,m,i){i+k-1 \choose i}=\sum\limits_{k=0}^{n+m} \delta(m,i) {n+i \brace i}\frac{i!}{(n+i)!}{i+k-1 \choose i}= $$ $$ ={n+m \brace m}\frac{m!}{(n+m)!}{m+k-1 \choose m}. $$ Now let 's use the theorem Lagrange on the inverse function, according to which for a power series $u(x,t)$ satisfying the functional equation $$ u=x\,F(g,t) $$ where $F(x,t)$ - s a power series for which $F(0,0)\neq 0$ holds the identity. $$ [x^n]u(x,t)=\frac{k}{n}[x^{n-k}]F(x,t)^n. $$ Let 's write down the functional equation for our case $F(x,t)=\frac{1}{1-t\frac{e^x-1}{x}}$ $$ u=\frac{x}{1-t\frac{e^{u}-1}{u}}. $$ The solution to this equation will be $$ u(x,t)^k=\sum\limits_{n>0} \sum\limits_{m\geqslant 0} \frac{k}{n}D(n-k,m,n)x^n\,t^m $$ where $D(n,m,k)$ where are the coefficients of the series $F(x,t)^k$. Then $$ D(n-k,m,n)={n+m-k \brace m}\frac{m!}{(n+m-k)!}{m+n-1 \choose m} $$ For $k=1$ we get $$ u(x,t)=\sum\limits_{n>0} \sum\limits_{m\geqslant 0} \frac{1}{n}{n+m-1 \brace m}\frac{m!}{(n+m-1)!}{m+n-1 \choose m}x^n\,t^m $$ or, after simplifying the binomial coefficient and factorials, we get $$ u(x,t)=\sum\limits_{n>0} \sum\limits_{m\geqslant 0} \frac{1}{n!}{n+m-1 \choose m}x^n\,t^m $$ Thus, the function $u(x,t)$ is the inverse of the function $y(x,t)=(x-t(e^x-1))$. Now let's use the Lambert function and its properties. The Lambert function is given by the equation $$ x=W(x)e^{W(x)} $$ It is known that solutions of the equation of the form $$ g(x)=f(x)e^{f(x)} $$ the solution will be $$ f(x)=W(g(x)) $$ We use this property for our case $$ y=x(y,t)-t\,e^{x(t,y)}+t $$ We will make a replacement $$ z(y,t)=x(y,t)+t-y $$ Then the equation will have the form $$ z(y,t)=t\,e^{Z(y,t)-t+y} $$ Let 's rewrite it in the form $$ z(y,t)e^{-Z(y,t)}=t\,e^{y-t} $$ Then the solution for $z(y,t)$ will have the form $$ z(y,t)=-W(-t\,e^{y-t}) $$ Where from $$ x(y,t)=y-t-W(-t\,e^{y-t}) $$ Now consider the product $$ E(x,t)=\sum_{n>0}P_n(t)\frac{x^n}{n!}\,(1-t)^{2n-1}=\frac{1}{1-t}\sum_{n>0}P_n(t)\frac{(x(1-t)^2)^n}{n!} $$ Where from $$ E(x,t)=\frac{E_2(x(1-t)^2,t)}{(1-t)}=\frac{x(1-t)^2-t-W(-t\,e^{x(1-t)^2-t})}{1-t}. $$ Differentiating by $x$ the expression for $E(x,t)$ taking into account the properties of the derivative of the Lambert function $W(x)$ we obtain the desired generating function $$ Eu(x,t)=\sum\limits_{n>0} \sum_{m>0} {\left\langle \left\langle \matrix{n\cr m} \right\rangle \right\rangle} \frac{x^n}{n!}t^m={1-t\over{W(-t\,e^{(1-t)^2\,x-t})+1}} $$ </div> <div id="15" class="article"> 15. Finding explicit expressions for decomposing the composition of generating functions of many variables </div> <div> Consider the composition of generating functions $F(x)$ and $G(x,y,\ldots,z)$, $G(0,0,\ldots,0)=0$ Then $A(x,y,\ldots,z)=F(G(x,y,\ldots,z))$ $$ \sum_{k=0}^{n+m+\ldots, i} G^{\Delta}(n,m,\ldots,i,k)f(k) $$ $$ [x^n\,y^m\,\ldots\,z^i](x+y+\ldots+z)^k={n+m+\ldots+i\choose n,m,\ldots,i}\delta(n+m+\ldots+i,k) $$ $$ [x^n\,y^m\,\ldots\,z^i]F(x+y+\ldots+z)=\sum_{k=0}^{n+m+\ldots+i}{n+m+\ldots+i\choose n,m,\ldots,i}\delta(n+m+\ldots+i,k)f(k)= $$ $$ {n+m+\ldots+i\choose n,m,\ldots,i}f(n+m+\ldots+i) $$ Example $$ e^{\frac{x}{1-x-y-z}} $$ $$ [x^n\,y^m\,z^i]\left(\frac{1}{1-x-y-z}\right)^k= $$ $$ \sum_{j=0}^{n+m+i} {n+m+i\choose n,m,i}\delta(n+m+i,j){j+k-1\choose j}= $$ $$ {n+m+i\choose n,m,i}{n+m+i+k-1\choose n+m+i} $$ Where from $$ [x^n\,y^m\,z^i]\left(\frac{x}{1-x-y-z}\right)^k={n-k+m+i\choose n-k,m,i}{n+m+i-1\choose n-k+m+i} $$ $$ [x^n\,y^m\,z^i]e^{\left(\frac{x}{1-x-y-z}\right)}=\sum_{k=0}^{n+m+i}\frac{1}{k!}{n-k+m+i\choose n-k,m,i}{n+m+i-1\choose n-k+m+i}= $$ $$ \sum_{k=0}^{n}\frac{1}{k!}{n-k+m+i\choose n-k,m,i}{n+m+i-1\choose n-k+m+i} $$ </div> <div id="16" class="article"> 16. Finding explicit expressions for decomposing functions of the form $G(x,y,\ldots,z)^{\alpha}$ </div> <div> Let the function $G(x,y,\ldots,z)$, $G(0,0,\ldots,0)\neq 0$ and be given and the coefficients of the k-th degree are given $$ G(x,y,\ldots,z)^k=\sum_{n\geqslant 0}\sum_{m\geqslant 0} T(n,m,\ldots,i,k)x^n\,y^m. $$ Then for the coefficients of the expansion $G(x,y,\ldots,z)^{-\alpha}$ will have the expressions <div class="formula"> $$ \sum_{j=0}^{n+m+\ldots+i} \frac{(-1)^{j}}{T (0 ,0,\ldots,0,1)^{j+\alpha}} \binom{j+\alpha-1}{j} T(n,m,\ldots,i,j) \binom {n+m+\ldots+i+\alpha}{n+m+\ldots+i-j} $$ <span class="formula_number">(17)</span> </div> and <div class="formula"> $$ (n+m+\ldots+i+1) {n+m+\ldots+i+\alpha\choose n+m+\ldots+i+1} \sum_{j=0}^{n+m+\ldots+i} \frac{(-1)^{j} {n+m+\ldots+i\choose j} }{(j+\alpha) T(0 ,0,\ldots,0,1)^{j+\alpha}} $$ <span class="formula_number">(18)</span> </div> </div> <div id="17" class="article">17. How the encyclopedia was created</div> <div> Consider the method of obtaining pyramids. o do this, we write down the set of generating functions of one variable and the corresponding set of explicit expressions of coefficients $k$-degrees. . Let there be a set of $G=\{g_i(x)\}$ generating functions, the coefficients of $k$-degree are described by binomial coefficients of $\{T_i(n,k)\}$. $$ \begin{array}{|c|c|}\hline \hbox{Generating function }G(x) &\hbox{Coefficients of degree } g_x(n,k)\\ \hline (1+x) & \binom{k}{n}\\ \hline \frac{1}{1-x} & \binom{n+k-1}{n}\\ \hline \frac{1-\sqrt{1-4x}}{2x} & \frac{k}{n+k}{2n+k-1\choose n}\\ \hline \frac{1-2x-\sqrt{1-4x}}{2x^2} & \frac{k}{n+k}{2n+2k\choose n}\\ \hline \frac{2}{\sqrt{3x}} \sin({ {\arcsin( {3^ {3\over{2}} \sqrt{x} \over {2} } )} \over {3} }) & {k\,{3\,n+k-1 \choose n }}\over{2\,n+k}\\ \hline 1+\sqrt{1+4x}\over{2} & k(-1)^{n-1}{2n-k-1 \choose n-1}\over{n}\\ \hline 1-\frac{4}{3} \sin ^2({ {\arcsin( {3^ {3\over{2}} \sqrt{-x} \over {2} } )} \over {3} }) & k(-1)^{n-1}{3n-k-1 \choose n-1}\over{n} \\ \hline \sqrt{1+4x} & \cases{ \begin{array} \binom {\binom{k \over 2}n} 4^{n} & k-even \\ \frac{(-1)^{n-{k+1 \over 2}} \binom {n} {k+1\over 2} \binom {2n} {n}} {\binom {2n}{k+1}}& k-odd, 2n>(k+1),\\ \frac{\binom{k+1}{2n}\binom {2n}{n}} {\binom{k+1\over 2} {n}} & k-odd,2n \le(k+1), \\ \end{array} }\\ \hline \sqrt{1+4x^2}+2x & \cases{ \begin{array}\\ \frac{k4^n}{n+k} \binom {n+k \over 2}{n},& n+k-even\\ \frac{k(-1)^{n-k-1\over2}\binom {n}{n+k+1 \over 2} \binom{2n}{n}}{(n+k) \binom{2n}{n+k+1}} &k-odd,n>(k+1),\\ \frac {k\binom{n+k+1}{2n} \binom{2n}{n}}{(n+k) \binom{n+k+1 \over 2}{n}}& n+k-odd,n\le(k+1),\\ \end{array} }\\ \hline {1\over \sqrt{1-4x}} & \cases{ \begin{array}\\ 4^n \binom {\frac{k}{2} + n-1}{n} & k-even, \\ \frac {\binom {2n+k-1}{\frac{k-1}{2}+n} \binom{\frac{k-1}{2}+n}{n}} {\binom{k-1}{k-1 \over 2}} ,& k-odd,\\ \end{array}} \\\hline {1\over 12x} + \frac{\sin (\frac{\arcsin(-1+216\,x^2)}{3})} {6x} & \cases{ \begin{array}\\ \frac{k4^n \binom {\frac{3n+k}{2}-1}{n}}{n+k}, & k - even,\\ \frac{k \binom{\frac{3n+k-1}{2}}{n} \binom{3n+k-1}{\frac{3n+k-1}{2}}} {(n+k) \binom{n+k-1}{\frac{n+k-1}{2}}}& k -odd \\\end{array} }\\ \hline \sqrt{\frac{1-\sqrt{1-16x}}{8x}} & \cases{ \begin{array}\\ \frac{k4^n \binom{\frac{4n+k}{2}-1}{n}}{2n+k} & k - even,\\ \frac{k \binom{\frac{4n+k-1}{2}}{n} \binom {4n+k-1} {\frac {4n+k-1} {2} }} {(2n+k)\binom{2n+k-1}{\frac{2n+k-1}{2}}} ,& k- odd.\\ \\ \end{array}} \\ \hline \sqrt{\frac{\sin (\frac{\arcsin(\sqrt {27x})}{3})} {\sqrt {3x}}} & \cases{ \begin{array}\\ \frac{k4^n \binom{\frac{6n+k}{2}-1}{n}}{4n+k} & k - even,\\ \frac{k \binom{\frac{6n+k-1}{2}}{n} \binom {6n+k-1} {\frac {6n+k-1} {2} }} {(4n+k)\binom{4n+k-1}{\frac{4n+k-1}{2}}} ,& k- odd.\\ \\ \end{array} }\\ \hline \end{array}$$ It should be noted that this table is significantly limited and is used as an example. Choose $g_1(x)\in G$ and $g_2(x)\in G$ and construct a new function of two variables. Two ways of obtaining pyramids of the generating function of two variables can be proposed:<br /><br /> 1. Based on the product and composition of functions $g_1(x)\in G$ and $g_2(x)\in G$. Let $g_1(x)=(1+x)$, $g_2(x)=\frac{1}{1-x}$ and the coefficients of k-degree $g_1(x)$ have the form: $$ T_1(n,k)={k \choose n}, $$ for $g_2(x)$ $$ T_2(n,k)={n+k-1 \choose n}, $$ Let's write a new function of two variables $$ U(x,y)=g_1(x)\cdot g_2(y) $$ Then the pyramid of the function $U(x,y)$ will have the expression $$ T_U(n,m,k)=T_1(n,k)\cdot T_2(m,k) $$ Then $$ U(x,y)=\frac{1+x}{1-y} $$ From where, we get the following pyramid $$ T_U(n,m,k)={k\choose n}{m+k-1\choose m}. $$ This pyramid is listed in the encyclopedia as number 17. We will expand this method by composing generating functions for obtaining pyramids. Let's choose $g_1(x)\in G$ and $g_2(x)\in G$ and build a new function of two variables $$ U(x,y)=g_1(x\cdot g_2(y))\,g_2(y) $$ Then the pyramid of the function $U(x,y)$ will have the expression $$ T_U(n,m,k)=T_1(n,k)\cdot T_2(m,n+k) $$ In general, you can write a function of the form $$ U(x,y)=g_1(x\cdot g_2(y)^a)^b\,g_2(y)^c $$ where $a,b,c\in N$ Then the pyramid of the function $U(x,y)$ will have the expression $$ T_U(n,m,k)=p_1(n,bk)\cdot p_2(m,an+ck) $$ For example, for $g_1(x)=(1+x)$, $g_2(x)=\frac{1}{1-x}$ (see the previous example), we will set the values $a=2$, $b=2$, $c=1$. Then the function will take the form $$ U(x,y):=\frac{1}{1-y}\left(1+\frac{x}{(1-y)^2}\right)^2 $$ From where the pyramid will have the expression: $$ T_U(n,m,k)=T_1(n,2k)T_2(m,2n+k)=\binom{2k}{n}\binom{m+2n+k-1}{m} $$ This pyramid is recorded in the encyclopedia under the number 1423.<br /><br /> 2. Consider a method for obtaining pyramids based on Lagrange's theorem. Let 's choose $g_1(x)\in G$ and $g_2(x)\in G$ and write a functional equation of the form: $$ U(x,y)=g_1(x\cdot g_2(y)^a\cdot U(x,y))^b\,g_2(y)^c $$ To do this, you need to find the coefficients of the degree $$ T(n,m,k)=[x^n\,y^m]\left(g_1(x\cdot g_2(y)^a)^b\,g_2(y)^c\right)^k=T_1(n,b\,k)T_2(m,a\,n+c\,k) $$ To do this, use the previous method. Where from $$ T_U(n,m,k)=\frac{k}{n+k}T_1(n,b(n+k))\cdot T_2(m,an+c(n+k)) $$ Let's take the initial data from the previous example. Then the functional equation will take the form: $$ U(x,y)=\left(1+\frac{x\,U(x,y)}{1-y)^2}\right)^2\frac{1}{1-y}. $$ As a result of the solution , we obtain the following generating function of two variables: $$ U(x,y)=\frac{(1-\sqrt{1-4x(1-y)^3}-2x) (1-y)^2}{2x^2} $$ Then $$ T_F(n,m,k)= \frac{k}{n+k} \binom{2n+2k}{n} \binom{3n+m+k-1}{m} $$ This pyramid is recorded in the encyclopedia under the number 1458. <br /> Using this technique, you can get a large number of pyramids. Currently, based on the use of this technique, 1502 pyramids have been obtained. </div> <div id="18" class="article">18. References</div> <div class="reference"> [1] The On-Line Encyclopedia of Integer Sequences, N. J. A. Sloane, Notices, Amer. Math. Soc., 65 (No. 9, Oct. 2018), 1062-1074. Reprinted in "The Best Writing on Mathematics 2019", ed. M. Pitici, Princeton Univ. Press, 2019, pp. 90-119 and colored illustrations following page 80. </div> <div class="reference"> [2] The Combinatorial Object Server (2021). http://combos.org. </div> <div class="reference"> [3] Kruchinin, D.; Kruchinin, V.; Shablya, Y. Method for Obtaining Coeff- cients of Powers of Bivariate Generating Functions. Mathematics 2021, 9, 428. https://doi.org/10.3390/math9040428 </div> <div class="reference"> [4] Kruchinin, D.V., Kruchinin, V.V. Application of a composition of generating functions for obtaining explicit formulas of polynomials (2013) Journal of Mathematical Analysis and Applications, 404 (1), pp. 161-171. </div> <div class="reference"> [5] Kruchinin, D.V., Kruchinin, V.V. Explicit formulas for some generalized polynomials (2013) Applied Mathematics and Information Sciences, 7 (5), pp. 2083-2088. </div> <div class="reference"> [6] V. V. Kruchinin and D. V. Kruchinin, Composita and its properties, J. Analysis and Number Theory 2 (2014), 1-8. </div> <div class="reference"> [7] V. V. Kruchinin and D. V. Kruchinin, A Method for Obtaining Generating Function for Central Coeffcients of Triangles Journal of Integer Sequences, Vol. 15 (2012), Article 12.9.3 </div> <div class="reference"> [8] V. V. Kruchinin and D. V. Kruchinin A Generating Function for the Diagonal T2n,n in Triangles Journal of Integer Sequences, Vol. 18 (2015), Article 15.4.6 </div> <div class="reference"> [9] D. V. Kruchinin On solving some functional equations Advances in Difference Equations, Vol. 1 (2015), 1687-1847. doi:10.1186/s13662-014-0347-9 </div> <div class="reference"> [10] DMITRY V. KRUCHININ and VLADIMIR V. KRUCHININ. (2019). Explicit formula for reciprocal generating function and its application. Advanced Studies in Contempo- rary Mathematics, 29(3), 365-372. </div> <div class="reference"> [11] (Ira M.). - A combinatorial proof of the multivariable Lagrange inversion formula. Jour- nal of Combinatorial Theory. Series A, vol. 45, n◦ 2, 1987, pp. 178-195. </div> <div class="reference"> [12] Clark Kimberling Path-counting and Fibonacci numbers, Fib. Quart. 40 (4) (2002) 328-338, </div> <div class="reference"> [13] Kruchinin, D., Kruchinin, V., Shablya, Y.On some properties of generalized Narayana numbers (2021) Quaestiones Mathematicae. DOI: 10.2989/16073606.2021.1980448 </div> <div class="reference"> [14] Stanley, Richard P. (2015), Catalan numbers. Cambridge University Press, ISBN 978- 1-107-42774-7. </div> <div class="reference"> [15] Kruchinin, Dmitry Kruchinin, Vladimir Shablya, Yuriy Shelupanov, Alexander. (2019). Explicit formulas for the Eulerian numbers of the second kind. AIP Conference Pro- ceedings. 2116. 100008. 10.1063/1.5114084. </div> </div>  "Laboratoriya algoritmov i tekhnologij issledovaniya diskretnyh struktur" (LATIDS) of the Faculty of "KSUP" "Laboratoriya algoritmov i tekhnologij issledovaniya diskretnyh struktur" stuff About Alina Polina Sergeevna Already have an account Application Are you sure, you want to delete Pyramid Author Browse through pyramid list By data Cancel Candidate of Physical and Mathematical Sciences Candidate of Technical Sciences, Senior Researcher Coefficients of the kth degree of the composition of
            generating functions Coefficients of the kth degree of the generating function of
            the solution of the functional equation Coefficients of the kth degree of the inverse generating
            function Coefficients of the kth degree of the mutual generating
            function Coefficients of the kth degree of the product of generating
            functions Coefficients of the kth degree of the sum of generating
            functions Condition Confirm deletion Confirm password Copy Darizhapov Artem Batoevich Data table Decomposition coefficients Decomposition of the composition Default Default: 
    by pyramid's 
        sequence number, 
        generating function, 
        explicit formula,
    by user's 
        username;
By data:
    by pyramid's
         data table (which you can see on pyramid's page specifically). Delete pyramid Designations Doctor of Technical Sciences, Associate Professor Doesn't match password Don't have an account? E-mail Edit profile Edit pyramid Edit your profile Error Euler triangle (Euler numbers of the first genus) Examples Explicit formula Export Export as LaTeX Export as Maxima Expression Features of this encyclopedia Fibonacci Numbers Fina Triangle Find out what this encyclopedia is for Finding explicit expressions for decomposing functions of the
            form Finding explicit expressions for decomposing functions of the
        form Finding explicit expressions for decomposing the composition of
        generating functions of many variables Finding mutual generating functions Finding the coefficients of inverse generating functions Finding the composition of logarithmic functions and their
        derivatives Finding the generating function for the explicit expression of
        coefficients Function name Function variables Generating function Generating function for second-order Euler numbers Generating function for the diagonal Getting the coefficients of the function Go to encyclopedia application Go to project info Go to pyramid list Group Project Training participants Head of the Laboratory Home How the encyclopedia was created Identity for harmonic numbers Interface language Invalid Email Keywords Kontsevaya Kristina Anatolyevna Korneeva Yulia Andreevna Kruchinin Dmitry Vladimirovich Kruchinin Vladimir Viktorovich LATIDS stuff Leading Researcher Learn more about the project team Log in Log out Obtaining coefficients of degrees of generating functions of one
        variable Obtaining explicit expressions of the composition of generating
        functions of one variable Obtaining explicit expressions of the composition of generating
        functions of two variables On this site you can Page Password Perminova Maria Yurievna Preview Project team Pyramid Pyramid list References Related Remember me Save profile Search Search for pyramids Search type Search... Shablya Yuri Vasilyevich Sign up Sorry, there's no such page. You can try going TUSUR students - group project training participants The methodology of use for the encyclopedia This pyramid is not valid. It'll be fixed as soon as posible Tomsk State University of Control Systems
        and Radioelectronics Try going back Update profile picture Upload pyramid Uploaded file User with such email already exists. User with such username already exists. Username Username or Email What tasks does this encyclopedia solve Why do we need another encyclopedia on mathematics Why do we need generating functions Your search and explore pyramids. and perform another search did not match anything home or search results Project-Id-Version: PROJECT VERSION
Report-Msgid-Bugs-To: EMAIL@ADDRESS
POT-Creation-Date: 2023-05-31 21:32+0700
PO-Revision-Date: 2023-05-31 21:33+0700
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language: ru
Language-Team: ru <LL@li.org>
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.12.1
 
  <div class="page">
    <div id="1" class="article">
      1. Зачем нужна еще одна энциклопедия по математике
    </div>
    <div class="paragraph">
      Базы математических знаний являются развитием математических справочников
      и энциклопедий и становятся важным инструментом в математических
      исследованиях и в исследованиях в смежных областях. Примерами таких баз
      знаний являются онлайн энциклопедия целых последовательностей
      <a href="#18" class="ref_link">[1]</a>, сервер комбинаторных объектов
      <a href="#18" class="ref_link">[2]</a>
      и др.
    </div>
    <div class="paragraph">
      Рассмотрим одну из самых известных таких баз знаний - онлайн энциклопедия
      целых последовательностей (www.oeis.org), которая насчитывает свыше
      трехсот тысяч последовательностей. Ежедневно десятки тысяч математиков,
      инженеров и студентов используют эту энциклопедию в своей работе при
      проведении исследований и учебных занятий. Каждая статья этой энциклопедии
      содержит<a href="#18" class="ref_link">[1]</a>:
    </div>
    <ol id="education">
      <li>Числовую последовательность;</li>
      <li>
        Комментарии, в которых описаны математические объекты, связанные с этой
        последовательностью;
      </li>
      <li>
        Формулы, задающие эту последовательность (производящая функция, явная
        или рекуррентная формула, уравнение;
      </li>
      <li>Список литературы связанный с этой последовательностью;</li>
      <li>
        Реализацию формул или алгоритмов вычисления этой последовательности в
        различных системах программирования (Maxima, Mathematica, Maple, и др.;
      </li>
      <li>Среду ссылок на интернет ресурсы;</li>
      <li>Примеры использования;</li>
      <li>Связь с другими последовательностями;</li>
      <li>
        Автора этой последовательности и авторов отдельных элементов этой
        последовательности.
      </li>
    </ol>
    <div class="paragraph">
      Основной функцией этой базы знаний является поиск и редактирование
      числовых последовательностей, которые могут быть двух типов: линейная
      последовательность и треугольник. Треугольник также представлен линейной
      последовательностью. Данная энциклопедия имеет ряд существенных
      недостатков:
    </div>
    <ol id="education">
      <li>Невозможно представить тензоры, имеющие 3 и более индексов;</li>
      <li>Устаревший интерфейс, формулы записываются в текстовом режиме;</li>
      <li>Поиск реализован только по элементам числовой последовательности;</li>
    </ol>
    <div class="paragraph">
      Описанные недостатки не умаляют значения этой базы знаний для
      математических исследований и практики использования числовых
      последовательностей и алгоритмов. Однако развитие математического аппарата
      композиции производящих функций многих переменных
      <a href="#18" class="ref_link">[3]</a> позволяет получать явные выражения
      коэффициентов производящих функций многих переменных и найти подходы и
      алгоритмы для реализации этой операции в системах компьютерной алгебры и
      первым шагом в этом направлении является создание соответствующей базы
      знаний для тензоров $T(n,m,k)$ описываемых произведениями биномиальных
      коэффициентов, являющимися коэффициентами $k$-степени производящей функции
      двух переменных.
    </div>
    <div class="paragraph">
      Предлагаемая энциклопедия является дополнением oeis.org в части
      представления производящих функций двух переменных и их коэффициентов
      $k$-ой степени.
    </div>
    <div id="2_art" class="article">2. Зачем нужны производящие функции</div>
    <div class="paragraph">
      Производящие функции математический аппарат обеспечивающий решение
      дискретных задач с помощью математического анализа. Производящие функции
      широко используются в комбинаторике, при анализе вычислительной сложности
      алгоритмов, в теории вероятности и математической статистики, в решении
      классов функциональных уравнений, при решении дифференциальных уравнений,
      при вычислении интегралов и т.д.
    </div>
    <div id="3" class="article">3. Особенности данной энциклопедии</div>
    <div class="paragraph">
      Производящих функций может огромное количество. Так в онлайн энциклопедии
      целых последовательность записано свыше 300 тыс. производящих функций. В
      данной энциклопедии насчитывается 1500 производящих функций двух
      переменных и их коэффициенты k-ой степени. Здесь представлено только
      производящие функции, коэффициенты k-ой степени которых представлены
      биномиальными коэффициентами. Можно выдвинуть гипотезу, что число
      производящих функций двух переменных выражения которых явно задано и
      коэффициенты их k-ой степени выражены биномиальными коэффициентами
      ограничено. Пример из энциклопедии типичной производящей функции и ее
      коэффициентов
      <div class="latex">
        $$U_{39}(x,y)= {1-\sqrt{1-4\,x-4\,x\,y}}\over{x\,\left(2+2\,y\right)}$$
      </div>

      Разложение производящей функции
      $$\begin{array}{llllll}1&0&0&0&0&0\\1&1&0&0&0&0\\2&4&2&0&0&0\\5&15&15&5&0&0\\14&56&84&56&14&0\\42&210&420&420&210&42\end{array}$$
    </div>
    <div id="4" class="article">4. Какие задачи решает данная энциклопедия</div>
    <div>
      <div class="paragraph">
        Развитие методологии решения задач, основанных на применении
        производящих функций многих переменных, представленной в работах
        <a href="#18" class="ref_link">[3-12]</a>
        позволило существенно расширить области их применения. Важным элементом
        стала база знаний для математических объектов, описываемых
        коэффициентами $k$-степени производящей функции двух переменных. Можно
        выделить следующие задачи решение которых можно осуществить с помощью
        данной базы знаний:
      </div>
      <br />
      <ol id="education">
        <li>
          нахождение явной формулы коэффициентов композиции производящих функций
          и их степеней $$ F(x,y,\ldots,G(x,y,\ldots,z),\ldots,z)^k $$
        </li>
        <li>
          нахождение явных формул для взаимной производящей функции и их
          степеней $$ \frac{1}{G(x,y,\ldots,z)^k} $$
        </li>
        <li>
          нахождение явных формул для производящей функции вида $$
          G(x,y,\ldots,z)^{\alpha} , \alpha\in R $$
        </li>
        <li>
          нахождение явных формул для обратной производящей функции и их
          степеней; $$ G(x,y,\ldots,z)=\frac{y}{F\left(x,y\cdot
          G(x,y,\ldots,z),\ldots,z\right)} $$
        </li>
        <li>
          нахождение явных формул для реверсивной производящей функции и их
          степеней;\ $$ G(x,y,\ldots,z)=F(x,y\,G(x,y,\ldots,z),\ldots,z) $$
        </li>
        <li>
          нахождение явных формул для реверсивной производящей функции и их
          степеней;\ $$ G(x,y,\ldots,z)=F(x,y\,G(x,y,\ldots,z),\ldots,z) $$
        </li>
        <li>
          нахождение явных формул для обратной реверсивной производящей функции
          двух переменных и их степеней; $$
          G(x,y,\ldots,z)=F\left(x,\frac{y}{G(x,y,\ldots,z)},\ldots,z\right) $$
        </li>
        <li>
          нахождение явных выражений логарифмических производных $$
          \log(G(x,y,\ldots,z)) $$
        </li>
      </ol>
    </div>
    <div id="5" class="article">5. Ключевые слова</div>
    <div>
      <ul>
        <li>производящая функция</li>
        <li>обыкновенная производящая функция</li>
        <li>экспоненциальная производящая функция</li>
        <li>производящая функция одной переменной</li>
        <li>производящая функция двух переменных</li>
        <li>производящая функция многих переменных</li>
        <li>коэффициент производящей функции</li>
        <li>коэффициент производящей функции одной переменной</li>
        <li>коэффициент производящей функции двух переменных</li>
        <li>коэффициент производящей функции многих переменных</li>
        <li>коэффициент k-ой степени производящей функции</li>
        <li>коэффициент k-ой степени производящей функции одной переменной</li>
        <li>коэффициент k-ой степени производящей функции двух переменных</li>
        <li>коэффициент k-ой степени производящей функции многих переменных</li>
        <li>композита</li>
        <li>функциональной уравнение</li>
        <li>композиция производящих функций</li>
        <li>композиция производящих функций одной переменной</li>
        <li>композиция производящих функций двух переменных</li>
        <li>композиция производящих функций многих переменных</li>
        <li>взаимная производящая функция</li>
        <li>взаимная производящая функция одной переменной</li>
        <li>взаимная производящая функция двух переменных</li>
        <li>взаимная производящая функция многих переменных</li>
        <li>обратная производящая функция</li>
        <li>обратная производящая функция одной переменной</li>
        <li>обратная производящая функция двух переменных</li>
        <li>обратная производящая функция многих переменных</li>
        <li>пирамида</li>
        <li>тензор</li>
      </ul>
    </div>
    <div id="6" class="article">6. Обозначения</div>
    <div class="designations">
      $F(x)=\sum_{n\geqslant 0} f(n)x^n$ - обыкновенная производящая функция
      (производящая функция)
      <br />
      $F(x)=\sum_{n\geqslant 0} f(n)\frac{x^n}{n!}$ - экспоненциальная
      производящая функция.
      <br />
      $F(n,k)$ - коэффициент k-ой степени производящей функции $F(x), F(0)\neq
      0$<br />

      $F^{\Delta}(n,k)$ - композита производящей функции $F(x), F(0)=0$<br />

      $N$- множество натуральных чисел, включая ноль.<br />
      $Z$ - множество целых чисел<br />

      $R$ - множество действительных чисел.<br />

      $[x^n]F(x)$ - операция извлечения коэффициента производящей функции $F(x)$
      при переменной $x^n$.<br />

      $F(x,y)=\sum_{n\geqslant 0}\sum_{m\geqslant 0} f(n,m)x^n\,x^m$ -
      обыкновенная производящая функция (производящая функция) двух
      переменных<br />

      $[x^n\,y^m]F(x,y)$ - операция извлечения коэффициента производящей функции
      $F(x,y)$ при переменных $x^n$ и $y^m$.<br />

      $F(n,m,k)$ - коэффициент k-ой степени производящей функции $F(x,y),
      F(0,0)\neq 0$<br />

      $F(x,y)\ldots,z)=\sum_{n\geqslant 0}\sum_{m\geqslant 0}\ldots\sum_{i
      \geqslant 0} f(n,m)x^n\,y^m\,\ldots z^i)$ - обыкновенная производящая
      функция (производящая функция) многих переменных переменных<br />

      $F^{\Delta}(n,m,k)$ - композита производящей функции $F(x,y), F(0,0)=0$<br />

      ${n\choose k}$ - биномиальный коэффициент $C_n^k$<br />

      $n\brack k$ - числа Стирлинга первого рода $s(n,k)\geqslant 0$ <br />

      $n \brace k $ - числа Стирлинга второго рода <br />

      $\left\langle \matrix{n \cr k } \right\rangle $ - числа Эйлера первого
      рода <br />

      $\left\langle \left\langle \matrix{n \cr k } \right\rangle \right\rangle $
      - числа Эйлера второго рода <br />

      $fib(n)$ - числа Фибоначчи<br />
    </div>
    <div id="7" class="article">
      7. Получение явных выражений композиции производящих функций одной
      переменной
    </div>
    <div>
      Пусть дана производящая функция $G(x)=\sum_{n>0} g(n)x^n$ и ее композита.
      $$ G^{\Delta}(n,k)=[x^n]G(x)^k. $$ $G^{\Delta}(0,0)=1$. Тогда для
      коэффициентов композиции производящих функций $A(x)=F(G(x))$ будет
      справедлива формула
      <div class="formula">
        \begin{equation}\label{Lcompos1} a(n)=\sum_{k=0}^n
        G^{\Delta}(n,k)\,f(k). \end{equation}
        <span class="formula_number">(1)</span>
      </div>
      Рассмотрим примеры
    </div>

    <div id="7_1" class="article">7.1 Числа Фибоначчи</div>

    <div>
      Найдем явное выражение для чисел Фибоначчи. $$ A(x)=\frac{x}{1-x-x^2} $$
      Представим производящую функцию композицией $$ A(x)=F(G(x)). $$ где
      $F(x)=\frac{1}{1-x}$, $G(x)=x+x^2$, $f(n)=1$, $G^{\Delta}(n,k)={k\choose
      n-k}$ $$ a(n)=\sum_{k=0}^n {k\choose n-k} $$
    </div>
    <div id="7_2" class="article">
      7.2 Коэффициенты разложения $\sinh{\left(\frac{x}{1-x}\right)}$
    </div>

    <div>
      Рассмотрим получение явного выражения для коэффициентов разложения
      $A(x)=\sinh{\left(\frac{x}{1-x}\right)}$. Известно, что $$
      \sinh(x)=\sum_{n>0} \frac{1-(-1)^n}{2}\frac{x^n}{n!} $$ Также известно,
      что $$ \left(\frac{x}{1-x}\right)^k=\sum_{n\geqslant k} Tp0002(n-k,k)x^n.
      $$ где (См. энциклопедию) $$ Tp0002(n,k)={n+k-1 \choose n}. $$ Тогда $$
      a(n)=\sum_{k=0}^n {n-1 \choose n-k} \frac{1-(-1)^k}{2\,(k!)} $$
    </div>

    <div id="7_3" class="article">
      7.3 Коэффициенты разложения $e^{\sin(x)}$
    </div>
    <div>
      Для нахождения разложения композиции $A(x)=e^{\sin(x)}$ необходимо знать
      композиту $\sin(x)$ (в энциклопедии записано под номером Tp0114)
      $$G^{\Delta}(n,k)={\frac{(1+(-1)^{n-k})}{2^{k}\,n!} \sum_{i=0}^{\lfloor
      {k\over{2}}\rfloor}{(2\,i-k)^{n}{k\choose{i}}\left(-1\right)^{-i+{k+n\over(2)}}}}$$
      Тогда $$ a(n)=\sum_{k=0}^n {\frac{(1+(-1)^{n-k})}{2^k n! k!} \sum_{i=0}^{
      \lfloor {k\over{2}}\rfloor}{(2\,i-k)^{n}{k\choose{i
      }}(-1)^{-i+{k+n\over{2}}}}} $$
    </div>
    <div id="7_4" class="article">
      7.4 Получение коэффициентов функции ${1-2x}\over{1-3\,x+x^2}$
    </div>
    <div>
      Пусть дана производящая функция $${1-2,x}\over{1-3\,x+x^2}$$ Перепишем ее
      в виде $$ \frac{x}{1-x}\frac{1}{1-\frac{x}{(1-x)^2}}+1 $$ Рассмотри
      композицию функций $A(x)=\frac{x}{(1-x)^2}$ и $\frac{1}{1-x}$ Композита
      функции $A(x)$ имеет выражение $$ A^{\Delta}(n,k)={n+k-1\choose n-k} $$
      Тогда $$ [x^n]\frac{1}{1-A(x)}=\sum_{k=0}^n {n+k-1\choose n-k} $$ $$
      \frac{x}{1-x}\frac{1}{1-A(x)}=\frac{x}{1-x}\left(1+\frac{x}{(1-x)^2}x+\frac{x^2}{(1-x)^4}x^2+\ldots+\frac{x^n}{(1-x)^{2n}}x^n+\ldots\right)=
      $$ $$
      =x\,\left(\frac{1}{1-x}+\frac{x}{(1-x)^3}x+\frac{x^2}{(1-x)^5}x^2+\ldots+\frac{x^n}{(1-x)^{2n+1}}x^n+\ldots\right)=
      $$ ряд записанный в скобках имеет нечетные степени $2n+1$. Откуда формула
      суммирования будет иметь вид. $$\sum_{k=0}^{n}{n+k\choose{n-k}}$$ С учетом
      сдвига на $x$ и плюс 1 (см. исходную формулу получим искомое выражение).
      $$[x^n]{1-2,x\over{1-3\,x+x^2}}=\sum_{k=0}^{n}{n+k-1\choose{2k}}$$
    </div>

    <div id="7_5" class="article">7.5 Тождество для гармнических чисел</div>
    <div>
      Пусть дана производящая функция для гармонических чисел
      $$H(x)=\frac{1}{1-x}\log\left(\frac{1}{1-x}\right)$$ Рассмотрим композицию
      функций $H(1-e^x)$. После подстановки и преобразований получим $$
      H(1-e^x)=-x\,e^x. $$ Зная, что композита функции $A(x)=e^x-1$ имеет
      выражение $$ A^{\Delta}(n,k)= {n\brace k} \frac{k!}{n!} $$ то $$
      [x^n](1-e^x)^k=(-1)^k\ {n \brace k} \frac{k!}{n!} $$ Откуда используя
      формулу композиции получим $$ [x^n]H(1-e^x)=\sum_{k=0}^n (-1)^k\ {n \brace
      k} \frac{k!}{n!}H_k, $$ где $H_k$ - гармонические числа. С другой стороны
      $$ [x^n]e^{-x}(-x)=\frac{(-1)^n}{(n-1)!}. $$ Теперь приравняем левую и
      правую части $$ \sum_{k=0}^n (-1)^k\ {n \brace k}
      \frac{k!}{n!}H_k=\frac{(-1)^n}{(n-1)!} $$ Произведем преобразования и
      получим тождество $$ \sum_{k=0}^n (-1)^{n-k}\,k!\, {n \brace k} \,H_k=n $$
    </div>

    <div id="8" class="article">
      8. Получение коэффициентов степеней производящих функций одной переменной
    </div>
    <div class="paragraph">
      Имеются простые правила вычисления коэффициентов степеней производящих
      функций
    </div>
    <div id="8_1" class="article">
      8.1 Коэффициенты $k$-ой степени суммы производящих функций
    </div>
    <div class="paragraph">
      Коэффициенты $k$-ой степени суммы производящих функций $$
      [x^n](F(x)+G(x))^k=[x^n]\sum_{j=0}^k {k\choose j}F(x)^j\,G(x)^{k-j}= $$
      <div class="formula">
        \begin{equation}\label{gfsum1} \sum_{j=0}^k{k\choose j}\sum_{i=0}^n
        F(i,j)G(n-i,k-j) \end{equation}
        <span class="formula_number">(2)</span>
      </div>
      Пример $$ \frac{1+x-x^3}{1-x}=\frac{1}{1-x}+x+x^2 $$ $$
      [x^n]\frac{1}{(1-x)^k}={n+k-1 \choose n} $$ $$ [x^n](x+x^2)^k={k \choose
      n-k} $$ $$ [x^n]\left(\frac{1+x-x^3}{1-x}\right)^k=\sum_{j=0}^k
      \sum_{i=0}^n {i+j-1\choose i}{k-j\choose n-i-k+j} $$
    </div>
    <div id="8_2" class="article">
      8.2 Коэффициенты $k$-ой степени произведения производящих функций
    </div>
    <div class="paragraph">
      Коэффициенты $k$-ой степени произведения производящих функций
      <div class="formula">
        \begin{equation}\label{gfprod1} [x^n](F(x)\cdot G(x))^k=\sum_{j=0}^n
        F(i,k)G(n-i,k) \end{equation}
        <span class="formula_number">(3)</span>
      </div>
      Пример<br />
      Пусть дана производящая функция $$
      \frac{1+x}{1-x}=1+2\,x+2\,x^2+2\,x^3+2\,x^4+2\,x^5+\cdots $$ Найдем
      коэффициенты k-ой степени этой функции используя формулу (3). $$
      [x^n]\left(\frac{1+x}{1-x}\right)^k=\sum_{i=0}^n {i+k-1\choose
      i}\,{k\choose n-i} $$
    </div>
    <div id="8_3" class="article">
      8.3 Коэффициенты $k$-ой степени композиции производящих функций
    </div>
    <div class="paragraph">
      <div class="formula">
        \begin{equation}\label{gfcomp1} [x^n](F(G(x))^k=\sum_{j=0}^n
        G^{\Delta}(n,j)F(j,k) \end{equation}
        <span class="formula_number">(4)</span>
      </div>
      $ G^{\Delta}(n,k)$ - композита функции $G(x)$ <br />
      Пример<br />
      Пусть дана производящая функция $$
      \frac{1}{1-sin(x)}=1+x+x^2+\frac{5x^3}{6}+\frac{2x^4}{3}+\frac{61x^5}{120}+\dots
      $$ Найдем коэффициенты k-ой степени этой функции используя формулу (4).
      Для этого необходимо знать композиту функции $\sin(x)$. Ее композита
      записана в энциклопедии под номером Tp0114 (см. раздел 7.3) $$
      [x^n]\left(\frac{1}{1-\sin(x)}\right)^k=\sum_{m=0}^n
      Tp0114(n,m){m+k-1\choose m} $$ здесь $F(x)=\frac{1}{1-x}$, $G(x)=\sin(x)$.
    </div>
    <div id="8_4" class="article">
      8.4 Коэффициенты $k$-ой степени взаимной производящей функции
    </div>
    <div class="paragraph">
      <div class="formula">
        \begin{equation}\label{gfrecip1} [x^n][x^n]\frac{1}
        {F(x)^k}=\sum_{i=0}^{n}F(0)^{-k-i}\,\left(-1\right)^{i}\,{k
        +i-1\choose{i}}\,F\left(n , i\right)\,{n+k\choose{n-i}} \end{equation}
        <span class="formula_number">(5)</span>
      </div>

      Пример<br />
      $$x\cot(x)=1-{\frac{x^2}{3}}-{\frac{x^4}{45}}-{\frac{2\,x^6}{945}}+\cdots
      $$ Пусть дана производящая функция. Найдем коэффициенты k-ой степени этой
      функции используя формулу (5). Для этого запишем $$
      x\cot(x)=\frac{x}{\tan(x)} $$ найдем композиту $\tan(x)$. В энциклопедии
      эта композита записана под номером $Tp0117$
      $$Tp0117(n,k)=\frac{((-1)^{n}+1)}{(n+k)!}\,\sum_{j=k}^{n+k}{j-1
      \choose{k-1}},j!,2^{n-j-1},(-1)^ {\frac {n+k}{2} + j} {n\brace j} $$
      $$[x^n](\frac{\tan(x)}{x})^k=Tp0117(n+k,k)=\frac{((-1)^{n}+1)}{(n+k)!}
      \sum_{j=k}^{n+k} {j-1 \choose k-1 } j! 2^{n+k-j-1} (-1)^{\frac{n+2k}{2}
      +j} {n+k \brace j} $$
      $$[x^n](\frac{\tan(x)}{x})^k=\frac{((-1)^{n}+1)}{(n+k)!} \sum_{j=0}^{n}
      {j+k-1 \choose k-1 } (j+k)! 2^{n+j-1} (-1)^{\frac{n}{2} +j} {n+k \brace
      j+k} $$ $$[x^n](\frac{\tan(x)}{x})^i=\frac{((-1)^{n}+1)}{(n+i)!}
      \sum_{j=0}^{n} {j+i-1 \choose i-1 } (j+i)! 2^{n+j-1} (-1)^{\frac{n}{2} +j}
      {n+i \brace j+i} $$ тогда искомая формула будет иметь выражение $$
      \sum_{i=0}^{n}{k+i-1\choose i}\, \frac{((-1)^{n}+1)}{(n+i)!}
      \sum_{j=0}^{n} {j+i-1 \choose i-1 } (j+i)! 2^{n+j-1}
      (-1)^{\frac{n}{2}+j+i} {n+i \brace j+i} \binom{n+k}{n-i} $$
    </div>
    <div id="8_5" class="article">
      8.5 Нахождение явных выражений для разложения функций вида
      $G(x)^{-\alpha}$, $\alpha\in R$
    </div>
    <div class="paragraph">
      <div class="formula">
        $$ \sum_{j=0}^{n} \frac{(-1)^j}{T(0,1)^{j+\alpha}} {j+\alpha-1 \choose
        j} {T(n,j)} {n+\alpha \choose n-j} $$
        <span class="formula_number">(6)</span>
      </div>
      и
      <div class="formula">
        $$ (n+1)\binom{n+\alpha}{n+i} \sum_{i=0}^{n}
        \frac{T(0,1)^{-j-\alpha}(-1)^{j} T(n,j){n\choose j}} {j+\alpha} $$
        <span class="formula_number">(7)</span>
      </div>
      Рассмотрим примеры <br />
      <b class="paragraph"> 8.5.1 Пример 1</b>

      $$ G(x)=(\frac{x}{e^x-1})^{\alpha} $$ $$ (e^x-1^k)=\sum_{n\geqslant k} {n
      \brace k} \frac{k!}{n!} x^n $$ $$ (\frac{e^x-1}{x})^k=\sum_{n\geqslant 0}
      {n+k \brace k} \frac{k!}{(n+k)!}x^n $$ $$ \sum_{j=0}^{n}(-1)^{j} \binom
      {j+\alpha-1}{j} {n+j \brace j} \frac{j!}{(n+j)!} { n+\alpha \choose n-j}
      $$ и $$ (n+1){n+\alpha \choose n+1}\sum_{j=0}^{n} \frac{(-1)^{j}j!
      {n+j\brace j} {n \choose j}} {(j+\alpha)(n+j)!} $$

      <b class="paragraph"> 8.5.2 Пример 2</b>
      $$ G(x)=(\sqrt{\cos(x)})^{3} $$ Для функции $cos(x)$ известно выражение
      коэффициенты разложения $cos(x)^k$. В энциклопедии под номер Tp0115. $$
      Tp0115(n,k)= \begin{array} 11, & n=0, \ \frac{(-1)^{n \over 2}
      {(-1)^{n}+1}} {2^{k} n!} \sum\limits_{i=0}^{k-1 \over 2} (k-2i)^{n}
      {k\choose i} & n>0.\ \end{array} $$ Воспользуемся формулой (6) при
      $\alpha=-\frac{3}{2}$, $Tp0115(0,1)=1$ $$ \sum_{j=0}^{n}(-1)^{j}
      \binom{j-\frac{3}{2}-1}{j} Tp0115(n,j) \binom{n-\frac{3}{2}}{n-j} $$
    </div>
    <div id="8_6" class="article">
      8.6 Коэффициенты $k$-ой степени производящей функции решения
      функционального уравнения $A(x)=G(x\,A(x)^m$, $m\in N$
    </div>
    <div class="paragraph">
      Пусть дано функциональной уравнение $A(x)=G(x\,A(x)^m$, $m\in N$ и
      известно выражение $$ [x^n]G(x)^k=G(n,k) $$ $G(0)\ne 0$. Тогда для
      коэффициентов степени $$ [x^n]A(x)^k=A(n,k) $$ выполняется следующее
      соотношение
      <div class="formula">
        \begin{equation}\label{gflagr1} A(n,k)=\frac{k}{m\,n+k}G(n,m\,n+k)
        \end{equation}
        <span class="formula_number">(8)</span>
      </div>

      Пример Пусть дано функциональной уравнение $$
      A(x)=\frac{1+x\,A(x)}{1-x\,A(x)} $$ $m=1$. Для решения этого уравнения
      необходимо найти $G(n,k)$. Известно (см. пример раздела 8.2), что $$
      [x^n]\left(\frac{1+x}{1-x}\right)^k=\sum_{i=0}^n {i+k-1\choose
      i}\,{k\choose n-i} $$ Подставляя найденной $G(n,k)$ в формулу (8) получим
      искомое решение $$ A(n,k)=\frac{k}{n+k}\sum_{i=0}^n {n+k+i-1\choose
      i}\,{n+k\choose n-i} $$ Теперь перепишем наше уравнение в виде $$
      x\,A(x)^2+1+(x-1)\,A(x)+1=0 $$ решаем его относительно $A(x)$ получим $$
      A(x)={1-x+\sqrt{1-6\,x+x^2}\over{2\,x}}$$ Откуда
      $$[x^n]\left({1-x+\sqrt{1-6\,x+x^2}
      \over{2\,x}}\right)^k=\frac{k}{n+k}\sum_{i=0}^n {n+k+i-1\choose
      i}\,{n+k\choose n-i}.$$ таким образом, найдена формула коэффициентов
      степени для производящей функции больших чисел Шредера (см. энциклопедию
      ...)
    </div>
    <div id="8_7" class="article">
      8.7 Коэффициенты $k$-ой степени обратной производящей функции
    </div>
    <div class="paragraph">
      Рассмотрим функциональное уравнение $$ A(x)\cdot G(A(x))=x $$ $G(0)\ne 0.$
      $$ G^{\Delta}(n,k)=[x^n]\left(x\,G(x)\right)^k. $$ Тогда
      <div class="formula">
        \begin{equation}\label{gfinver1}
        A^{\Delta}(n,k)=\frac{k}{n}\sum_{j=0}^{n-k} G(1,1)^{-n-j}(-1)^{j}
        {n+j-1\choose j}G^{\Delta}(n,j) {2\,n-k \choose n-k-j} \end{equation}
        <span class="formula_number">(9)</span>
      </div>

      Пример Пусть дана производящая функция $$ G(x)=\frac{\exp(x)+x-1}{2} $$
      Получим коэффициенты k-степени обратной функции. Для этого используем
      формулу (9). Найдем композиту функции $G(x)$, для этого воспользуемся
      формулой суммы: $B(x)=e^x-1$, ее композита ${n\choose k}\frac{k!}{n!}$ Для
      $C(x)=x$, композита $\delta(n,k)$. Тогда $$
      G^{\Delta}(n,k)=\sum_{j=0}^k{k\choose j}\sum_{i=0}^n {i \brace
      j}\frac{j!}{i!}\delta(n-i,k-j) $$ Теперь подставим $i=n-k+j$ $$
      G^{\Delta}(n,k)=\sum_{j=0}^k{k\choose j} {n-k+j\brace j}
      \frac{j!}{(n-k+j)!} $$ $$ G^{\Delta}(1,1)=1,$$ $$ A^{\Delta}(n,k)=
      \frac{k}{n}\sum_{j=0}^{n-k}(-1)^{j}\,{n+j-1\choose j}G{\Delta}(n,j)
      {2\,n-k \choose n-k-j} $$ Откуда получим тождество
      $$\sum_{j=k}^{n}{A^{\Delta}(j,k)\,G^{\Delta}(n,j)}=\delta(n,k)$$
    </div>
    <div id="8_8" class="article">
      8.8 Коэффициенты k-ой степени производящей функции решения функционального
      уравнения $A(x)=G\left(\frac{x}{A(x)}\right)$
    </div>
    <div>
      <div class="formula">
        \begin{equation}\label{gfleft1}
        A(n,k)=k\,\sum_{j=1}^{n}\frac{1}{j}{G}\left(0 ,
        1\right)^{-n+k-j}\left(-1 \right)^{j-1}{G}\left(n , j\right){n-k+j-1
        \choose j-1}{2\,n-k \choose n-j} \end{equation}
        <span class="formula_number">(10)</span>
      </div>
      ${\bf Пример}$ Пусть $$ G(x)=\frac{\log(1+x)}{x} $$ и $$
      G(n,k)=\frac{k!}{(n+k)!}{n+k \brack k}(-1)^n. $$ Запишем уравнение $$
      A(x)=G\left(\frac{x}{A(x)}\right)=\frac{\log(1+\frac{x}{A(x)}}{\frac{x}{A(x)}}
      $$ Откуда, получим производящую функцию для чисел Бернулли $$
      A(x)=\frac{x}{e^x-1} $$ Тогда $$ A(n,k)=k\,\sum_{j=1}^{n}\frac{1}{j}
      {\left(-1\right)^(n+j-1)}\frac{j!}{(n+j)!} {n+j \brack j}{n-k+j-1\choose
      j-1} {2,n-k \choose n-j} $$, $A(0,k)=1$
    </div>
    <div id="8_9" class="article">
      8.9 Производящая функция для диагонали $G(n,n)$
    </div>
    <div>
      Пусть задана производящая функция $G(x)=\sum_{n\geqslant 0} g(n)x^n$. и
      коэффициенты разложения ее степени $$ G(n,k)=[x^n]G(x)^k $$ Тогда
      производящая функция для диагонали $G(n,n)$ будет иметь выражение $$
      \frac{x\,A'(x)}{A(x)}, $$ где $A(x)$ является решением функционального
      уравнения $$ A(x)=G(x\,A(x)). $$ Если известна $A(n,k)$, то диагональ
      $G(n,n)$ будет иметь следующее выражение

      <div class="formula">
        \begin{equation} G(n,n)=n\,\sum_{j=1}^{n}\frac{(-1)^{j-1}\,A(n,j)}{j\,A(0,1)^{j}}\,{n\choose
        j}. \end{equation}
        <span class="formula_number">(11)</span>
      </div>

      Пример Пусть дана производящая функция $$ G(x)=\frac{1+x-x^2}{1-x} $$ и
      задано выражение для коэффициентов степени $$
      [x^n]G(x)^k=G(n,k)=\sum_{j=0}^{\left \lfloor {n \over 2} \right \rfloor}{k
      \choose j}\,{n-j-1\choose n-2\,j} $$ Необходимо найти производящую функцию
      для диагонали $G(n,n)$. Для этого необходимо решить уравнение $$
      A(x)=G(x\,A(x)=\frac{1+x\,A(x)-x^2\,A(x)^2}{1-A(x)} $$
      $$A(x)^2\,\left(x^2+x\right)+A(x),\left(-x-1\right)+1=0$$ $$A(x)=1+x-\sqrt
      {1-2x-3x^2}\over{2\,x+2\,x^2}$$ Находим логарифмическую производную
      $$B(x)=\frac{(xA(x))'}{A(x)}\frac{1}{2} ({1\over
      1+x}+{1\over\sqrt{1-2x-3x^2}}) $$ откуда $$
      [x^n]B(x)=G(n,n)=\sum_{j=0}^{\left \lfloor {n \over 2 } \right \rfloor}{n
      \choose j}\,{n-j-1 \choose n-2\,j} $$
    </div>
    <div id="8_10" class="article">
      8.10 Разложение композиции $F(x)=\log(A(x))$
    </div>
    <div>
      Следствием утверждений пункта 8.9 является, что для композиции функций
      $F(x)=\log(A(x))$ коэффициенты разложения будут иметь выражение
      <div class="formula">
        \begin{equation}\label{gflog1}
        f(n)=\sum_{j=1}^{n}\frac{(-1)^{j-1}\,A(n,j)}{j\,A(0,1)^{j}}\,{n\choose
        j}. \end{equation}
        <span class="formula_number">(12)</span>
      </div>
      Рассмотрим примеры<br />
      Пример 1 $$ \log\left(\frac{1}{1-x}\right) $$ $$
      [x^n]\left(\frac{1}{1-x}\right)^k={n+k-1\choose n} $$
      $$\sum_{j=1}^{n}\frac{(-1)^{j-1}}{j}{n+j-1\choose n}{n \choose
      j}=\frac{1}{n}$$ Пример 2 $$\log(e^x)=x$$ $$\sum_{j=1}^{n}
      (-1)^{j-1}\,{n\choose j}j^{n-1}=\left\{\begin{array}{ll} 1,& n=1,\ 0,&
      n>0. \end{array}\right.$$
    </div>
    <div id="9" class="article">
      9. Получение явных выражений композиции производящих функций двух
      переменных
    </div>
    <div class="paragraph">
      Рассмотрим решение задачи нахождения явной формулы для композиции
      производящих функций двух переменных. Для этого запишем таблицу 1,
      полученную в <a href="#18" class="ref_link">[3]</a>. В первом столбце
      записаны варианты композиции производящих функций, во втором - явные
      выражения коэффициентов $k$-ой степени производящей функции выражение
      через коэффициенты $k$-ой степени производящих функций образующих
      композицию. При $k=1$ получим коэффициенты композиции производящих
      функций.
    </div>
    <div>
      <table border="1" class="table">
        <caption>
          Таблица формул для определения коэффициентов степеней композиции рядов
        </caption>
        <tr>
          <th>N</th>
          <th>Композиция $G(x,y)^k$</th>
          <th>Формула для $g(n,m,k)$</th>
        </tr>
        <tr>
          <td>1</td>
          <td>$G(x,y)^k=H(A(x),y)^k$</td>
          <td>$g(n,m,k)=\sum\limits_{q=0}^n A^{\Delta}(n,q)h(q,m,k)$</td>
        </tr>
        <tr>
          <td>2</td>
          <td>$G(x,y)^k=H(x,B(y))^k$</td>
          <td>$g(n,m,k)=\sum\limits_{r=0}^m B^{\Delta}(m,r)h(n,r,k)$</td>
        </tr>
        <tr>
          <td>3</td>
          <td>$G(x,y)^k=H(A(x,y))^k$</td>
          <td>$g(n,m,k)=\sum\limits_{q=0}^{n+m} A^{\Delta}(n,m,q)h(q,k)$</td>
        </tr>
        <tr>
          <td>4</td>
          <td>$G(x,y)^k=H(A(x,y),y)^k$</td>
          <td>
            $g(n,m,k)=\sum\limits_{q=0}^{n+m}\sum\limits_{r=0}^{m}{A^{\Delta}\left(n
            ,m-r,q\right)h(q,r,k)}$
          </td>
        </tr>
        <tr>
          <td>5</td>
          <td>$G(x,y)^k=H(x,B(x,y))^k$</td>
          <td>
            $g(n,m,k)=\sum\limits_{q=0}^{n}{\sum\limits_{r=0}^{n+m-q}{B^{\Delta}\left(n-q
            ,m,r\right)}\,h(q,r,k)}$
          </td>
        </tr>
        <tr>
          <td>7</td>
          <td>$G(x)^k=H(x,B(x))^k$</td>
          <td>
            $g(n,k)=\sum\limits_{q=0}^{n}{\sum\limits_{r=0}^{n-q}{B^{\Delta}(n-q,r)\,
            h(q,r,k)}}$
          </td>
        </tr>
      </table>
      <div class="paragraph">
        Для выполнения композиции $G(x,y)=H(A(x,y),y)$ необходимо знать условие,
        что внутренняя функция $A(0,0)=0$. В разработанной базе знаний есть
        много функций, имеющие свободный член $A(0,0)\ne=0$. Для достижения
        заданного условия можно воспользоваться способами : домножением
        производящей функции на переменную моном $x^ay^b$, где $a,b \in N$,
        $a\geqslant 0$, $b\geqslant 0$ или вычитанием из производящей функции
        нулевого элемента разложения.
      </div>
      $$G(x,y)={x,y-1\over{x,y+x^2+x-1}}$$ ее можно представить как $$
      G(x,y)=\frac{1}{1-\frac{x+x^2}{1-x\,y}}=H(A(x,y)), $$ где
      $H(x)=\frac{1}{1-x}$, $A(x,y)=\frac{x+x^2}{1-x\,y}$ В базе знаний делаем
      запрос на производящую функцию $U(x,y)=\frac{1+x}{1-y}$. Получим найденную
      пирамиду под номером 17. Тогда для композиты функции $x\frac{1+x}{1-y}$
      будет верна формула $$ T_{17}(n-k,m,k)={k\choose{n-k}}\,{m+k-1\choose{m}}
      $$
      <div class="fragment">
        Generating function:
        <br />
        $U_{17}(x,y)={1+x\over{1-y}}$
        <br />
        Formula: $T_{17}(n,m,k)={k\choose{n}}\,{m+k-1\choose{m}}$
        <br />
        Data:
        <br />
        $\begin{array}{lllllll}1&1&1&1&1&1&1\\1&1&1&1&1&1&1\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0
        \\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\ \end{array} $
      </div>

      Теперь выполним выполним произведение переменной $y$ на $x$ получим $$
      A^{\Delta}(n,m,k)=T_{17}(n-m-k,m,k)={k\choose{n-k}}\,{m+k-1\choose{m}} $$
      Откуда на основании формулы композиции двух переменных (см. таблица 1,
      строка 3, $k=1$) $$ g(n,m)=\sum_{k=0}^{n+m}
      A^{\Delta}(n,m,k)=\sum_{k=0}^{n-m}{k\choose{n-m-k}}\,{m+k-1\choose{m}}. $$
      Таким образом, получили явную формулу для треугольника последовательности
      A055830, описывающий класс путей на решетке
      <a href="#18" class="ref_link">[12]</a>.
    </div>
    <div id="10" class="article">
      10. Нахождение взаимных производящих функций
    </div>
    <div>
      Пусть задана производящая функция вида:
      $$G(x,y)={x-\sqrt{x^2-2\,x^2\,y+2\,\sqrt{1-4\,x}\,x^2\,y}}\over{2\,x^2\,y}$$ Найдем
      явную формулу взаимной производящей функции: $$ A(x,y)=\frac{1}{G(x,y)} $$
      Разложим функцию $G(x,y)$ в ряд Тейлора в точке $x=0$ и $y=0$ $$
      \begin{array}{l}\ 1\ +\left(1+y+\cdots \right)\,x\
      +\left(2+2\,y+2\,y^2+\cdots \right)\,x^2\
      +\left(5+5\,y+6\,y^2+5\,y^3+\cdots \right)\,x^3\
      +\left(14+14\,y+18\,y^2+20\,y^3+14\,y^4+\cdots \right)\,x^4+\cdots
      \end{array}$$ Заметим, что эта функция описывает треугольник и $G(0,0)=1$.
      Тогда запишем функцию $H\left(x,\frac{y}{x}\right)$. Ищем эту функцию в
      базе знаний, получим функцию и тензор под номером 69 (см. раздел 10)

      <div class="fragment">
        Generating function:
        <br />
        $U_{69}(x,y)=x-\sqrt{x^2-2\,x\,y+2,\sqrt{1-4\,x}\,x\,y}\over{2\,x\,y}$
        <br />
        Formula: $T_{69}(n,m,k)={k,{2\,m+k-1 \choose{m}}, {2\,n+m+k-1\choose{n}}}
        \over{n+m+k}$
        <br />
        Data:
        <br />
        $\begin{array}{lllllll}1&1&2&5&14&42&132\\1&2&6&20&70&252&924
        \\2&5&18&70&280&1134&4620\\5&14&56&240&1050&4620&20328
        \\14&42&180&825&3850&18018&84084\\42&132&594&2860&14014&68796&336336
        \\132&429&2002&10010&50960&259896&1319472\end{array}$
      </div>
      Тогда для исходной функции будет верно выражение: $$
      G(x,y)=\sum_{n}\sum_{m} T_{69}(n-m,m,k)x^n\,y^m. $$ Для получения
      выражения коэффициентов взаимной производящей функции можно
      воспользоваться выражением<a href="#18" class="ref_link">[10]</a>:
      $$T_r(n,m,k)=\sum_{j=0}^{m+n}{T(0 , 0 ,
      1)^{-j-k}(-1)^{j}{j+k-1\choose{j}}{\it T}\left(n , m , j\right)
      {k+m+n\choose{m+n-j}}}$$ где $T(n,m,k)$ - тензор для исходной производящей
      функции, при условии, что $T(0,0,0)=1$ и $T(n,m,0)=0$. Запишем тензор для
      исходной функции $$
      T(n,m,k)=T_{69}(n-m,m,k)={\frac{k}{n+k}{2\,m+k-1\choose{m}}{2\,n+k-1\choose{n-m}}}.
      $$ Тогда тензор взаимной производящей функции будет иметь явное выражение
      $$ T_r(n,m,k)=\sum_{j=0}^{m+n}(-1)^{j} {j+k-1\choose{j}} {\frac{j}{n+j}}
      {2\,m+j-1\choose{m}} {2\,n+j-1\choose{n-m}} {k+m+n\choose{m+n-j}}. $$
    </div>
    <div id="10_1" class="article">
      10.1 Нахождение явных выражений для разложения функций вида
      $G(x,y)^{\alpha}$
    </div>
    <div>
      Пусть $$ G(x,y)^k=\sum_{n\geqslant 0}\sum_{m\geqslant 0} T(n,m,k)x^ny^m $$
      $G(0,0)\neq 0$. Тогда коэффициенты разложения функции $$
      \frac{1}{G(x,y)^{\alpha}} $$ будут иметь следующие выражения
      <div class="formula">
        \begin{equation} \sum_{j=0}^{n+m}{\frac{(-1)^{j}} {T(0,0,1)^{j+\alpha}}
        {j+\alpha-1\choose{j}}{\it T}(n,m,j) {n+m+\alpha \choose{n+m-j}}}
        \end{equation}
        <span class="formula_number">(13)</span>
      </div>
      и
      <div class="formula">
        \begin{equation} (n+m+1){n+m+\alpha\choose{n+m+1}}\sum_{j=0}^{n}
        T(0,0,1)^{-j-\alpha} (-1)^{j} T(n,m,j) {n+m\choose{j}} \over{j+\alpha}
        \end{equation}
        <span class="formula_number">(14)</span>
      </div>

      Рассмотрим пример $$ \frac{x+y}{\log(1+x+y)} $$ $$
      (\log(1+x)^k=\sum_{n\geqslant k} {n \brack k} \frac{k!}{n!}\,x^n $$ $$
      \left(\frac{\log(1+x)}{x}\right)^k=\sum_{n\geqslant 0} (-1)^n\, {n+k
      \brack k} \frac{k!}{(n+k)!}x^n $$ Найдем композицию $$
      A(B(x,y))=\frac{\log(1+x+y)}{x+y} $$ где $A(x)=\log(1+x)$, $B(x,y)=x+y$.
      Найдем в энциклопедии функцию $B(x,y)$.Эта функция записана по номером
      0001. Откуда $$ B(x,y)^k= \sum_{n\geqslant 0} \sum_{m \geqslant 0}
      \delta_{k, n+m}\, {n+m \choose m }\,x^n\,y^m $$ Тогда используем формулу
      композиции (см. табл. ) Получим $$ \sum_{j=0}^{n+m}
      B^{\Delta}(n,m,k)A^{\Delta}(j,k)= $$ $$ \sum_{j=0}^{n+m} \delta_{j, n+m}
      \,{n+m \choose m }(-1)^j\,{j+k \brack k}\frac{k!}{(j+k)!}= $$ $$ {n+m
      \choose m}(-1)^{n+m} {n+m+k \brack k} \frac{k!}{(n+m+k)!} $$ $$
      \sum_{j=0}^{n+m} {\left(-1\right)^{j}\,}\ { j+\alpha-1 \choose j} {n+m
      \choose m} (-1)^{n+m} {n+m+j \brack j} \frac{j!}{(n+m+j)!}\, {n+m+\alpha
      \choose n+m-j} $$
    </div>
    <div id="11" class="article">
      11. Нахождение коэффициентов обратных производящих функций
    </div>
    <div>
      Пусть дана производящая функция $$ F(x,y)=\frac{x}{1-x-x^2(1+y)} $$ Найдем
      коэффициенты разложения обратной функции, удовлетворяющей уравнению $$
      G(A(x,y),y)=x . $$ Для этого запишем $$ G_x(x,y)=\frac{G_x(x,y)}{x}. $$
      Тогда уравнение примет вид: $$ A(x,y)=\frac{x}{G_x(A(x,y),y)} $$ Теперь
      выполним подстановку $A(x,y)=xA_x(x,y)$ $$
      A_x(x,y)=\frac{x}{G_x(A_x(x,y),y)} $$ Тогда для нахождения обратной
      функций можно воспользоваться формулой. Однако в данном случае взаимную
      взаимную функцию легко найти. $$ G_{r}(x,y)=1-x-x^2(1+y)=(1-x(1+x+xy). $$
      Теперь находим пирамиду $T(n,m,k)$ функции $F(x,y)=(1+x+xy)$ под номером
      37 (см. фрагмент ниже)
      <div class="fragment">
        Generating function:<br />
        $U_{37}(x,y)=1+x+x\,y$
        <br />
        Formula: $T_{37}(n,m,k)={k\choose{n}}\,{n\choose{m}}$ Data:
        $\begin{array}{lllllll}1&0&0&0&0&0&0\\1&1&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\\0&0&0&0&0&0&0\end{array}$
      </div>
      $$ T_r(n,m,k)=\sum_{i=0}^{n+m} T_{37}(n-i,m,i){k\choose
      i}(-1)^i=\sum_{i=0}^{n+m} {i\choose{n-i}}\,{n-i\choose{m}}{k\choose
      i}(-1)^i= $$ $$ \sum_{i=0}^{n} {i\choose{n-i}}\,{n-i\choose{m}}{k\choose
      i}(-1)^i $$ Тогда коэффициенты для $A_x(x,y)^k$ $$
      T_{A_x}(n,m,k)=\frac{k}{n+k}T_r(n,m,n+k)=\frac{k}{n+k}\sum_{i=0}^{n}
      {i\choose{n-i}}\,{n-i\choose{m}}{k+n\choose i}(-1)^i $$
      $${\sqrt{4\,x^2\,y+5\,x^2+2\,x+1}-x-1}\over{2\,x^2\,y+2\,x^2}$$
    </div>
    <div id="12" class="article">
      12. Нахождение производящей функции для явного выражения коэффициентов
    </div>
    <div>
      Пусть задано выражение
      $$\sum_{k=0}^{m}{n+m-k+2\choose{k}}{n+m-k\choose{n}}$$ Произведем ряд
      преобразований с целью получить одну из композиционных формул,
      представленных в <a href="#18" class="ref_link">[3]</a>.
      $$\sum_{k=0}^{m}{n+m-k+2\choose{ k}}{m-k+n\choose{n}}$$ поменяем порядок
      суммирования с $k$ на $m-k$ $$\sum_{k=0}^{m}{n+k+2\choose{
      m-k}}{k+n\choose{n}}$$ теперь индекс $k$ начинается не с нуля а с $n$
      $$\sum_{k=n}^{n+m}{k+2\choose{ n+m-k}}{k\choose{n}}$$ теперь индекс $k$
      начинается с нуля $$\sum_{k=0}^{n+m}{k+2\choose{
      n+m-k}}\,{k\choose{k-n}}$$ вводим новую переменную и вводим суммирование
      по этой переменной, применя символ Кронекера $$ j=n+m-k $$ получим
      $$\sum_{k=0}^{n+m}{\sum_{j=0}^{m}{\delta_{j, n+m-k} \,{k+2\choose{
      j}}\,{-j+n+m\choose{m-j}}}}$$ теперь сравним с композиционной формулой
      $$g(n,m)=\sum\limits_{k=0}^{n+m}\sum\limits_{j=0}^{m}{A^{\Delta}\left(n
      ,m-j,k\right)h(k,j)}$$ Заметим, что для нашего случая $$ A^{\Delta}\left(n
      ,m-j,k\right)={\delta_{j, n+m-k}{-j+n+m\choose{m-j}}} $$ Откуда $$
      A^{\Delta}(n ,m,k)={\delta_{k, n+m}{n+m\choose{m}}} $$ Откуда используя
      энциклопедию найдем пирамиду под номером 1, производящая функция ее
      является $(x+y)$. Теперь найдем производящую функцию для $$
      h(n,m)={n+2\choose{ m}} $$ Делаем запрос к базу знаний:
      $T=binomial(n+2,m)$ Получим пирамиду под номером 42 (см. фрагмент ниже)
      <div class="fragment">
        Generating function:
        <br />
        $U_{42}(x,y)={\left(1+y\right)^2}\over{1-x\,\left(1+y\right)}$ Formula:
        <br />
        $T_{42}(n,m,k)={n+k-1\choose{n}}\,{n+2k\choose{m}}$ Data:
        $\begin{array}{lllllll}1&2&1&0&0&0&0\\1&3&3&1&0&0&0\\1&4&6&4&1&0&0\\1&5&10&10&5&1&0\\1&6&15&20&15&6&1\\1&7&21&35&35&21&7\\1&8&28&56&70&56&28\end{array}$
      </div>
      Откуда получим искомую производящую функцию. $$ A(x,y)=UU0042(x+y,y)=
      {\left(y+1\right)^2 \over 1-\left(y+1\right)\,\left(y+x\right)} $$
    </div>
    <div id="13" class="article">
      13. Нахождение композиции логарифмических функций и их производных
    </div>
    <div>
      1. Пусть дано функциональной уравнение вида: $$ A(x,y)=G(x\,A(x,y),y) $$ И
      известно выражение коэффициентов k-степени производящей функции $G(x,y)$.
      $$ T_G(n,m,k)=[x^n\,y^m]G(x,y)^k. $$ тогда тогда коэффициенты
      логарифмической частной производной производящей функции $A(x,y)$ по $x$ ,
      будут выражаться через коэффициенты $T_G(n,m,k)$ $$
      T_{lx}(n,m)=[x^n\,y^m]\frac{1}{A(x,y)}\frac{\partial A(x,y)}{\partial x}
      $$ $$ T_{lx}(n,m)=T_G(n,m,n) $$ 2. Пусть дано функциональное уравнение
      вида: $$ A(x,y)=G(x,y\,A(x,y)) $$ И известно выражение коэффициентов
      k-степени производящей функции $G(x,y)$. $$ T_G(n,m,k)=[x^n\,y^m]G(x,y)^k.
      $$ тогда тогда коэффициенты логарифмической частной производной
      производящей функции $A(x,y)$ по $y$ , будут выражаться через коэффициенты
      $T_G(n,m,k)$ $$ T_{ly}(n,m)=[x^n\,y^m]\frac{1}{A(x,y)}\frac{\partial
      A(x,y)}{\partial y} $$ $$ T_{ly}(n,m)=T_G(n,m,m) $$ Найдем коэффициенты
      логарифмической производной производящей функции $A_{139}(x,y)$
      Соответствующей ей фрейм в базе знаний показан на фрагменте ниже.
      <div class="fragment">
        Generating function:<br />
        $U_{139}(x,y)=\frac{1-2\,x-y-\sqrt{1-4\,x-(2-4\,x)\,y+y^2}}{2\,x^2}$
        Formula:<br />
        $T_{139}(n,m,k)={k\,{n+m+k\choose{m}}{2n+2k\choose{n}}\over{n+m+k}}$
        Data:
        $\begin{array}{lllllll}1&1&1&1&1&1&1\\2&4&6&8&10&12&14\\5&15&30&50&75&105&140\\14&56&140&280&490&784&1176\\42&210&630&1470&2940&5292&8820\\132&792&2772&7392&16632&33264&60984\\429&3003&12012&36036&90090&198198&396396\end{array}$
        <br />
        Right on y: UU0138(x,y)<br />
        Left on x: UU0059(x,y)<br />
        Left on y: UU0060(x,y)<br />
        Change x y: UU0359(x,y)<br />
      </div>
      Далее переходим по ссылке на фрейм 59 и копируем явную формулу для тензора
      производящей функции UU0059(x,y). $$ T_{59}(n,m,k)=\frac{k {\binom{2
      k}{n}} {\binom{k + m}{m}}}{k + m} $$ Для искомой логарифмической
      производной $$ G(x,y)=\frac{1}{A(x,y)}\frac{\partial A(x,y)}{\partial x}=
      1-2\,x^2-{2\,x^2\over{U(x\,y)}}+{x^2\,(4-4\,y)\over{2{\it U}\left(x ,
      y\right)\,\sqrt{1-4\,x-\left(2-4\,x\right)\,y+y^2}}}, $$ где $$
      U(x,y)=1-2\,x-y-\sqrt{1-4\,x-\left(2-4\,x\right)\,y+y^2}. $$ коэффициенты
      будут иметь явное выражение $$
      g(n,m)=T_{59}(n,m,n)={n\,{2\,n\choose{n}}\,{m+n\choose{m}}\over{m+n}}=\binom{2n}{n}\binom{n+m-1}{m}.
      $$ 3. Рассмотрим случай когда левый тензор для данной производящей функции
      неизвестен, но имеется тензор данной функции. Тогда можно воспользоваться
      следующими формулами. Формула для частной логарифмической производной по
      переменной $x$ следующая: $$ T_{logx}(n,m)=\left\{\begin{array}{ll}\
      T(0,0,1)^n & n=0\;, m=0,\
      n\,\sum_{j=1}^{n+m}{(-1)^{j-1}\,T(n,m,j)\,{n+m\choose{j}} \over{T^{j}(0 , 0
      , 1)j}}, & n>0\;or\; m>0.\ \end{array} \right. $$ Формула для частной
      логарифмической производной по переменной $x$ следующая: $$
      T_{logy}(n,m)=\left\{\begin{array}{ll}\ T(0,0,1)^m & n=0\;, m=0,\ m\,
      \sum_{j=1}^{n+m}{(-1)^{j-1}\, T(n , m , j){n+m\choose{j}}} \over{T^{j}(0 ,
      0 , 1)\,j}, & n>0\;or\; m>0.\ \end{array} \right. $$ сравнивая приведенные
      выше формулы для частных логарифмических производных можно увидеть, что
      они отличаются множителями $m$ и $n$. Члены $T_{logx}(n,m)$ и
      $T_{logy}(n,m)$ описывают разложение логарифмической производной, если
      члены $T_{logx}(n,m)$ на $n$, а $T_{logy}(n,m)$ на $m$, получим члены
      разложения композиции производящих функций $$ log(U(x,y)), $$ гду
      $U(x,y)$- производящая функция имеющая тензор $T(n,m,k)$. Запишем явную
      формулу для членов композиции $$ Lo(n,m)=\sum_{j=1}^{n+m}{(-1)^{j-1} T(n ,
      m , j){n+m\choose{j}} \over{T^{j}(0 , 0 , 1)j}} $$ Рассмотрим пример.
      Пусть дана производящая функция под номер 130.
      <div class="fragment">
        Generating function: $$U_{130}(x,y)= {1 \over -4\,y+(1-x+y)^2}$$ Formula:
        $$T_{130}(n,m,k)={m+k\choose{k-1}}{n+k-1\choose{k-1}}{n+m+2\,k-1\choose{
        k-1}}{2\,(n+m)+2\,k\choose{2\,m+1}}\over{2\,{2\,k-2
        \choose{k-1}}{2m+2\,k\choose{2\,k-2}}}$$ Data:
        $$\begin{array}{lllllll}1&2&3&4&5&6&7\\2&10&28&60&110&182&280\\3&28&126&396&1001&2184&4284\\4&60&396&1716&5720&15912&38760\\5&110&1001&5720&24310&83980&248710\\6&182&2184&15912&83980&352716&1248072\\7&280&4284&38760&248710&1248072&5200300\end{array}$$
      </div>
      Тогда коэффициенты разложения композиции функций $$
      \log(UU_{130}(x,y)=\log({1\over{-4\,y+(1-x+y)^2}}) $$ $$
      Lo(n,m)=\sum_{k=1}^{n+m} (-1)^{k-1} { {m+k\choose{k-1}}
      {n+k-1\choose{k-1}} {n+m+2\,k-1\choose{k-1}} {2\,(n+m)+2\,k\choose{2\,m+1}}
      \over 2\,k\,{2\,k-2\choose{k-1}}\,{2\,m+2\,k\choose{2\,k-2}} } {n+m\choose{k}} $$
    </div>
    <div id="14" class="article">14.Примеры</div>
    <div id="14_1" class="article">14.1 Пример 1. Треугольник Фина</div>
    <div>
      Рассмотрим производящую функцию для треугольника Фина $$
      G(x,y)={2\over{1+\sqrt{1-4\,x}+2\,x-2\,x\,y}} $$
      $$G(x,y)=\frac{A(x)}{1-y\,A(x)}.$$ $$A(x)=\frac{2}{1+\sqrt{1-4\,x}+2\,x}$$
      $$ G(x,y)=A(x)\,y+A(x)^2\,y^2+\ldots+A(x)^n\,y^n+\ldots $$ $A(x)$ -
      является производящей функцией последовательности Фина (см. $Up0157(x)$).
      Тогда $$ G(x,y)=\sum_{n\geqslant k} Tp0157(n,k)\,x^n\,y^k $$
    </div>
    <div id="14_2" class="article">
      14.2 Пример 2. Треугольник Эйлера (числа Эйлера первого рода)
    </div>
    <div>
      Производящая функция для чисел Эйлера первого рода
      $$E(x,y)={y-1\over{y-e^{x(y-1)}}}$$ Представим ее в виде
      $$E(x,y)={1\over{1-\frac{e^{x,(y-1)}-1}{y-1}}}$$ Рассмотрим функцию $$
      A(x,y)=\frac{e^{x(y-1)}-1}{y-1} $$ Тогда ее можно представить композицией
      функций $$ A(x,y)=x\,B(C(x,y)), $$ где $B(x)=\frac{e^x-1}{x}$ и
      $C(x,y)=x\,(y-1)$. Тогда $B(x)=Up0102(x)/x$ $$
      B(x)^k=(\frac{e^x-1}{x})^k=\sum_{n\geqslant 0} Tp0102(n+k,k)x^n. $$ где
      $$Tp0102(n,k)=\frac{k!}{n!}\,{n \brace k}$$ Используя энциклопедию найдем
      $C(x)^k$ $$ C(x)^k=\sum_{n\geqslant
      k}\,Tuu0002(n,m,k)\,(-1)^{m+k}\,x^n\,y^m $$ $$ Tuu0002(n,m,k)=\delta_{k,
      n} \,{n\choose m} $$ Находим коэффициенты $B(C(x))^k$ $$ \sum_{j=0}^{n+m}
      Tuu0002(n,m,j)(-1)^{m+j}Tp0102(j+k,k)= $$ $$ \sum_{j=0}^{n+m}\delta_{j, n}
      \,{n\choose m}(-1)^{m+j}\frac{k!}{(j+k)!}\,{j+k \brace k}= $$ $$ {n
      \choose m }(-1)^{n+m}\frac{k!}{(n+k)!}\,{n+k \brace k}. $$ Находим
      коэффициенты $x\,B(C(x))^k$ $$ {n-k\choose m
      }(-1)^{n+m-k}\frac{k!}{n!}\,{n \brace k}= $$ Откуда находим явное
      выражение для коэффициентов разложения искомой композиции $$
      \sum_{k=0}^{n} {n-k\choose m}(-1)^{n+m-k}\frac{k!}{n!}\,{n \brace k} $$
      Тогда числа Эйлера первого рода будут иметь следующее явное выражение $$
      {\left\langle \matrix{n\cr m} \right\rangle}=\sum_{k=0}^{n-m}
      (-1)^{n+m-k}\,k!\,{n-k \choose m} {n \brace k} $$
    </div>
    <div id="14_3" class="article">
      14.3 Пример 3. Производящая функция для чисел Эйлера второго порядка
    </div>
    <div>
      Рассмотрим применение энциклопедии для получения производящей функции для
      чисел Эйлера второго рода. Для этого докажем следующую теорему.
      <br />
      <b>Теорема 2</b> Экспоненциальная производящая функция для чисел Эйлера
      второго порядка имеет вид:
      <div class="formula">
        $$ \sum\limits_{n \geqslant 0} \sum_{m\geqslant \geqslant0}
        {\left\langle \left\langle \matrix{n\cr m} \right\rangle \right\rangle}
        \frac{x^n}{n!}t^m={1-t\over{W(-t e^{(1-t)^2,x-t})+1}}, $$
        <span class="formula_number">(15)</span>
      </div>

      где $W(x)$ - функция Ламберта, $x>0$.
      <br />
      <b>Доказательство </b>Запишем экспоненциальную производящую функцию в виде
      двойного ряда, при этом возьмем смещение на $(n-1)$ $$ E(x,t) =
      \sum_{n>0}\sum_{m>0} {\left\langle \left\langle \matrix{n-1\cr m}
      \right\rangle \right\rangle} \frac{x^n}{n!}t^m $$ Рассмотрим формулу,
      полученную в <a href="#18" class="ref_link">[15]</a>
      <div class="formula">
        $$ {\left\langle \left\langle \matrix{n\cr m} \right\rangle
        \right\rangle} =\sum_{k=0}^m (-1)^{m-k}\,{2\,n+1 \choose m-k} {n+k
        \choose k}, $$
        <span class="formula_number">(16)</span>
      </div>

      Ее можно представить как произведение двух рядов $$
      E(x,t)=\sum_{n>0}P_n(t)\frac{x^n}{n!}\,(1-t)^{2n-1} $$ где $$
      (1-t)^{2\,n-1}=\sum_{n\geqslant 0}(-1)^m\,{2\,n-1 \choose m}t^m $$ и $$
      P_n(t)=\sum_{m\geqslant 0}{n+m-1 \brace m}t^m $$ Запишем функцию $$
      u(x,t)=\sum_{n>0}\sum_{m\geqslant 0}{n+m-1 \brace m}\frac{x^n}{n!}t^m $$
      Покажем, что эта функция является обратной функцией для функции $$
      y(x,t)=(x-t(e^x-1)). $$ Запишем взаимную функцию для $y(x,t)$ $$
      \frac{x}{y(x,t)}=\frac{1}{1-t\frac{e^x-1}{x}} $$ и найдем ее степень. Для
      этого запишем $$ (t(\frac{e^x-1}{x}))^k=\sum_{n>0}
      \sum_{m>0}T(n,m,k)x^nt^n $$ Известно, что для функции $(e^x-1)$ имеется
      тождество $$ (e^x-1)^k=\sum\limits_{n\geqslant 0} k!{n \brace
      k}\frac{x^n}{n!}, $$ получим $$ T(n,m,k)=\delta(m,k){n+k \brace
      k}\frac{k!}{(n+k)!}, $$ где $\delta(m,k)$ символ Кронекера. Для функции
      $\frac{1}{(1-x)}$ известно тождество $$ \frac{1}{(1-x)^k}=\sum_{n\geqslant
      0} {n+k-1 \choose n}x^n. $$ Тогда для степени композиции двух производящих
      функций $$ ({1 \over 1-t\frac{e^x-1}{x}})^k =\sum\limits_{n\geqslant 0}
      \sum\limits_{m\geqslant 0} D(n,m,k)x^nt^m, $$ на основе композиционной
      формулы \cite{kru}, можно записать $$ D(n,m,k)=\sum\limits_{i=0}^{n+m}
      T(n,m,i){i+k-1 \choose i}=\sum\limits_{k=0}^{n+m} \delta(m,i) {n+i \brace
      i}\frac{i!}{(n+i)!}{i+k-1 \choose i}= $$ $$ ={n+m \brace
      m}\frac{m!}{(n+m)!}{m+k-1 \choose m}. $$ Теперь воспользуется теоремой
      Лагранжа об обратной функции, согласно которой для степенного ряда
      $u(x,t)$ удовлетворяющему функциональному уравнению $$ u=x\,F(g,t) $$ где
      $F(x,t)$ - степенной ряд, у которого $F(0,0)\neq 0$ выполняется тождество
      $$ [x^n]u(x,t)=\frac{k}{n}[x^{n-k}]F(x,t)^n. $$ Запишем функциональное
      уравнение для нашего случая $F(x,t)=\frac{1}{1-t\frac{e^x-1}{x}}$ $$
      u=\frac{x}{1-t\frac{e^{u}-1}{u}}. $$ Решением этого уравнения будет $$
      u(x,t)^k=\sum\limits_{n>0} \sum\limits_{m\geqslant 0}
      \frac{k}{n}D(n-k,m,n)x^n\,t^m $$ где $D(n,m,k)$ коэффициенты ряда
      $F(x,t)^k$. Тогда $$ D(n-k,m,n)={n+m-k \brace m}\frac{m!}{(n+m-k)!}{m+n-1
      \choose m} $$ При $k=1$ получим $$ u(x,t)=\sum\limits_{n>0}
      \sum\limits_{m\geqslant 0} \frac{1}{n}{n+m-1 \brace
      m}\frac{m!}{(n+m-1)!}{m+n-1 \choose m}x^n\,t^m $$ или, после упрощения
      биномиального коэффициента и факториалов получим $$
      u(x,t)=\sum\limits_{n>0} \sum\limits_{m\geqslant 0} \frac{1}{n!}{n+m-1
      \choose m}x^n\,t^m $$ Таким образом, функция $u(x,t)$ является обратной к
      функции $y(x,t)=(x-t(e^x-1))$. Теперь воспользуемся функцией Ламберта и ее
      свойствами. Функция Ламберта задается уравнением $$ x=W(x)e^{W(x)} $$
      Известно, что решения уравнения вида $$ g(x)=f(x)e^{f(x)} $$ решением
      будет $$ f(x)=W(g(x)) $$ Используем это свойство для нашего случая $$
      y=x(y,t)-t\,e^{x(t,y)}+t $$ Произведем замену $$ z(y,t)=x(y,t)+t-y $$
      Тогда на уравнение будет иметь вид $$ z(y,t)=t\,e^{Z(y,t)-t+y} $$
      Перепишим ее в виде $$ z(y,t)e^{-Z(y,t)}=t\,e^{y-t} $$ Тогда решение для
      $z(y,t)$ будет иметь вид $$ z(y,t)=-W(-t\,e^{y-t}) $$ Откуда $$
      x(y,t)=y-t-W(-t\,e^{y-t}) $$ Теперь рассмотрим произведение $$
      E(x,t)=\sum_{n>0}P_n(t)\frac{x^n}{n!}\,(1-t)^{2n-1}=\frac{1}{1-t}\sum_{n>0}P_n(t)\frac{(x(1-t)^2)^n}{n!}
      $$ Откуда $$
      E(x,t)=\frac{E_2(x(1-t)^2,t)}{(1-t)}=\frac{x(1-t)^2-t-W(-t\,e^{x(1-t)^2-t})}{1-t}.
      $$ Дифференцируя по $x$ выражение для $E(x,t)$ с учетом свойств
      производной функции Ламберта $W(x)$ получим искомую производящую функцию
      $$ Eu(x,t)=\sum\limits_{n>0} \sum_{m>0} {\left\langle \left\langle
      \matrix{n\cr m} \right\rangle \right\rangle}
      \frac{x^n}{n!}t^m={1-t\over{W(-t\,e^{(1-t)^2\,x-t})+1}} $$
    </div>
    <div id="15" class="article">
      15. Нахождение явных выражений для разложения композиции производящих
      функций многих переменных
    </div>
    <div>
      Рассмотрим композицию производящий функций $F(x)$ и $G(x,y,\ldots,z)$,
      $G(0,0,\ldots,0)=0$ Тогда $A(x,y,\ldots,z)=F(G(x,y,\ldots,z))$ $$
      \sum_{k=0}^{n+m+\ldots, i} G^{\Delta}(n,m,\ldots,i,k)f(k) $$ $$
      [x^n\,y^m\,\ldots\,z^i](x+y+\ldots+z)^k={n+m+\ldots+i\choose
      n,m,\ldots,i}\delta(n+m+\ldots+i,k) $$ $$
      [x^n\,y^m\,\ldots\,z^i]F(x+y+\ldots+z)=\sum_{k=0}^{n+m+\ldots+i}{n+m+\ldots+i\choose
      n,m,\ldots,i}\delta(n+m+\ldots+i,k)f(k)= $$ $$ {n+m+\ldots+i\choose
      n,m,\ldots,i}f(n+m+\ldots+i) $$ Пример $$ e^{\frac{x}{1-x-y-z}} $$ $$
      [x^n\,y^m\,z^i]\left(\frac{1}{1-x-y-z}\right)^k= $$ $$ \sum_{j=0}^{n+m+i}
      {n+m+i\choose n,m,i}\delta(n+m+i,j){j+k-1\choose j}= $$ $$ {n+m+i\choose
      n,m,i}{n+m+i+k-1\choose n+m+i} $$ Откуда $$
      [x^n\,y^m\,z^i]\left(\frac{x}{1-x-y-z}\right)^k={n-k+m+i\choose
      n-k,m,i}{n+m+i-1\choose n-k+m+i} $$ $$
      [x^n\,y^m\,z^i]e^{\left(\frac{x}{1-x-y-z}\right)}=\sum_{k=0}^{n+m+i}\frac{1}{k!}{n-k+m+i\choose
      n-k,m,i}{n+m+i-1\choose n-k+m+i}= $$ $$
      \sum_{k=0}^{n}\frac{1}{k!}{n-k+m+i\choose n-k,m,i}{n+m+i-1\choose n-k+m+i}
      $$
    </div>
    <div id="16" class="article">
      16. Нахождение явных выражений для разложения функций вида
      $G(x,y,\ldots,z)^{\alpha}$
    </div>
    <div>
      Пусть задана функция $G(x,y,\ldots,z)$, $G(0,0,\ldots,0)\neq 0$ и заданы
      коэффициенты k-ой степени $$ G(x,y,\ldots,z)^k=\sum_{n\geqslant
      0}\sum_{m\geqslant 0} T(n,m,\ldots,i,k)x^n\,y^m. $$ Тогда для коэффициенты
      разложения $G(x,y,\ldots,z)^{-\alpha}$ будут иметь выражения
      <div class="formula">
        $$ \sum_{j=0}^{n+m+\ldots+i} \frac{(-1)^{j}}{T (0
        ,0,\ldots,0,1)^{j+\alpha}} \binom{j+\alpha-1}{j} T(n,m,\ldots,i,j)
        \binom {n+m+\ldots+i+\alpha}{n+m+\ldots+i-j} $$
        <span class="formula_number">(17)</span>
      </div>
      и
      <div class="formula">
        $$ (n+m+\ldots+i+1) {n+m+\ldots+i+\alpha\choose n+m+\ldots+i+1}
        \sum_{j=0}^{n+m+\ldots+i} \frac{(-1)^{j} {n+m+\ldots+i\choose j}
        }{(j+\alpha) T(0 ,0,\ldots,0,1)^{j+\alpha}} $$
        <span class="formula_number">(18)</span>
      </div>
    </div>
    <div id="17" class="article">17. Как создавалась энциклопедия</div>
    <div>
      Рассмотрим методику получения пирамид. Для этого запишем множество
      производящих функций одной переменной и соответствующее множество явных
      выражений коэффициентов $k$-степени. Пусть имеется множество
      $G=\{g_i(x)\}$ производящих функций, коэффициенты $k$-степени описываются
      биномиальными коэффициентами $\{T_i(n,k)\}$.$$ \begin{array}{|c|c|}\hline \hbox{Производящая функция }G(x) &\hbox{Коэффициенты степени } g_x(n,k)\\ \hline (1+x) & \binom{k}{n}\\ \hline \frac{1}{1-x} & \binom{n+k-1}{n}\\ \hline \frac{1-\sqrt{1-4x}}{2x} & \frac{k}{n+k}{2n+k-1\choose n}\\ \hline \frac{1-2x-\sqrt{1-4x}}{2x^2} & \frac{k}{n+k}{2n+2k\choose n}\\ \hline \frac{2}{\sqrt{3x}} \sin({ {\arcsin( {3^ {3\over{2}} \sqrt{x} \over {2} } )} \over {3} }) & {k\,{3\,n+k-1 \choose n }}\over{2\,n+k}\\ \hline 1+\sqrt{1+4x}\over{2} & k(-1)^{n-1}{2n-k-1 \choose n-1}\over{n}\\ \hline 1-\frac{4}{3} \sin ^2({ {\arcsin( {3^ {3\over{2}} \sqrt{-x} \over {2} } )} \over {3} }) & k(-1)^{n-1}{3n-k-1 \choose n-1}\over{n} \\ \hline \sqrt{1+4x} & \cases{ \begin{array} \binom {\binom{k \over 2}n} 4^{n} & k-even \\ \frac{(-1)^{n-{k+1 \over 2}} \binom {n} {k+1\over 2} \binom {2n} {n}} {\binom {2n}{k+1}}& k-odd, 2n>(k+1),\\ \frac{\binom{k+1}{2n}\binom {2n}{n}} {\binom{k+1\over 2} {n}} & k-odd,2n \le(k+1), \\ \end{array} }\\ \hline \sqrt{1+4x^2}+2x & \cases{ \begin{array}\\ \frac{k4^n}{n+k} \binom {n+k \over 2}{n},& n+k-even\\ \frac{k(-1)^{n-k-1\over2}\binom {n}{n+k+1 \over 2} \binom{2n}{n}}{(n+k) \binom{2n}{n+k+1}} &k-odd,n>(k+1),\\ \frac {k\binom{n+k+1}{2n} \binom{2n}{n}}{(n+k) \binom{n+k+1 \over 2}{n}}& n+k-odd,n\le(k+1),\\ \end{array} }\\ \hline {1\over \sqrt{1-4x}} & \cases{ \begin{array}\\ 4^n \binom {\frac{k}{2} + n-1}{n} & k-even, \\ \frac {\binom {2n+k-1}{\frac{k-1}{2}+n} \binom{\frac{k-1}{2}+n}{n}} {\binom{k-1}{k-1 \over 2}} ,& k-odd,\\ \end{array}} \\\hline {1\over 12x} + \frac{\sin (\frac{\arcsin(-1+216\,x^2)}{3})} {6x} & \cases{ \begin{array}\\ \frac{k4^n \binom {\frac{3n+k}{2}-1}{n}}{n+k}, & k - even,\\ \frac{k \binom{\frac{3n+k-1}{2}}{n} \binom{3n+k-1}{\frac{3n+k-1}{2}}} {(n+k) \binom{n+k-1}{\frac{n+k-1}{2}}}& k -odd \\\end{array} }\\ \hline \sqrt{\frac{1-\sqrt{1-16x}}{8x}} & \cases{ \begin{array}\\ \frac{k4^n \binom{\frac{4n+k}{2}-1}{n}}{2n+k} & k - even,\\ \frac{k \binom{\frac{4n+k-1}{2}}{n} \binom {4n+k-1} {\frac {4n+k-1} {2} }} {(2n+k)\binom{2n+k-1}{\frac{2n+k-1}{2}}} ,& k- odd.\\ \\ \end{array}} \\ \hline \sqrt{\frac{\sin (\frac{\arcsin(\sqrt {27x})}{3})} {\sqrt {3x}}} & \cases{ \begin{array}\\ \frac{k4^n \binom{\frac{6n+k}{2}-1}{n}}{4n+k} & k - even,\\ \frac{k \binom{\frac{6n+k-1}{2}}{n} \binom {6n+k-1} {\frac {6n+k-1} {2} }} {(4n+k)\binom{4n+k-1}{\frac{4n+k-1}{2}}} ,& k- odd.\\ \\ \end{array} }\\ \hline \end{array}$$      Необходимо отметить, что данная таблица существенно
      ограничена и используется в качестве примера. Выберем $g_1(x)\in G$ и
      $g_2(x)\in G$ и строим новую функцию двух переменных. Можно предложить два
      способа получения пирамид производящей функции двух переменных:<br /><br />
      1. На основе произведения и композиции функций $g_1(x)\in G$ и $g_2(x)\in
      G$. Пусть $g_1(x)=(1+x)$, $g_2(x)=\frac{1}{1-x}$ и коэффициенты k-степени
      $g_1(x)$ будут иметь вид: $$ T_1(n,k)={k \choose n}, $$ для $g_2(x)$ $$
      T_2(n,k)={n+k-1 \choose n}, $$ Запишем новую функцию двух переменных $$
      U(x,y)=g_1(x)\cdot g_2(y) $$ Тогда пирамида функции $U(x,y)$ будет иметь
      выражение $$ T_U(n,m,k)=T_1(n,k)\cdot T_2(m,k) $$ Тогда $$
      U(x,y)=\frac{1+x}{1-y} $$ Откуда, получим следующую пирамиду $$
      T_U(n,m,k)={k\choose n}{m+k-1\choose m}. $$ Эта пирамида в энциклопедии
      записана под номером 17. Расширим этот метод за счет композиции
      производящих функций получения пирамид. Выберем $g_1(x)\in G$ и $g_2(x)\in
      G$ и строим новую функцию двух переменных $$ U(x,y)=g_1(x\cdot
      g_2(y))\,g_2(y) $$ Тогда пирамида функции $U(x,y)$ будет иметь выражение
      $$ T_U(n,m,k)=T_1(n,k)\cdot T_2(m,n+k) $$ В общем случае, можно записать
      функцию вида $$ U(x,y)=g_1(x\cdot g_2(y)^a)^b\,g_2(y)^c $$ где $a,b,c\in
      N$ Тогда пирамида функции $U(x,y)$ будет иметь выражение $$
      T_U(n,m,k)=p_1(n,bk)\cdot p_2(m,an+ck) $$ Например, для $g_1(x)=(1+x)$,
      $g_2(x)=\frac{1}{1-x}$ (см. предыдущий пример, зададим значения $a=2$,
      $b=2$, $c=1$. Тогда функция примет вид $$
      U(x,y):=\frac{1}{1-y}\left(1+\frac{x}{(1-y)^2}\right)^2 $$ Откуда пирамида
      будет иметь выражение: $$
      T_U(n,m,k)=T_1(n,2k)T_2(m,2n+k)=\binom{2k}{n}\binom{m+2n+k-1}{m} $$ Эта
      пирамида записана в энциклопедии под номером 1423.<br /><br />
      2. Рассмотрим метод получения пирамид, основанный на теореме Лагранжа.
      Выберем $g_1(x)\in G$ и $g_2(x)\in G$ и запишем функциональное уравнение
      вида: $$ U(x,y)=g_1(x\cdot g_2(y)^a\cdot U(x,y))^b\,g_2(y)^c $$ Для этого
      необходимо найти коэффициенты степени $$
      T(n,m,k)=[x^n\,y^m]\left(g_1(x\cdot
      g_2(y)^a)^b\,g_2(y)^c\right)^k=T_1(n,b\,k)T_2(m,a\,n+c\,k) $$ Для этого
      воспользуемся предыдущим методом.Откуда $$
      T_U(n,m,k)=\frac{k}{n+k}T_1(n,b(n+k))\cdot T_2(m,an+c(n+k)) $$ Возьмем
      исходные данные из предыдущего примера. Тогда функциональное уравнение
      примет вид: $$
      U(x,y)=\left(1+\frac{x\,U(x,y)}{1-y)^2}\right)^2\frac{1}{1-y}. $$ В
      результате решения получим следующую производящую функцию двух переменных:
      $$ U(x,y)=\frac{(1-\sqrt{1-4x(1-y)^3}-2x) (1-y)^2}{2x^2} $$ Тогда $$
      T_F(n,m,k)= \frac{k}{n+k} \binom{2n+2k}{n} \binom{3n+m+k-1}{m} $$ Эта
      пирамида записана в энциклопедии под номером 1458.
      <br />
      Используя данную методику можно получить большое число пирамид. В
      настоящее время на основании использования этой методики получены 1502
      пирамиды.
    </div>
    <div id="18" class="article">18. References</div>
    <div class="reference">
      [1] The On-Line Encyclopedia of Integer Sequences, N. J. A. Sloane,
      Notices, Amer. Math. Soc., 65 (No. 9, Oct. 2018), 1062-1074. Reprinted in
      "The Best Writing on Mathematics 2019", ed. M. Pitici, Princeton Univ.
      Press, 2019, pp. 90-119 and colored illustrations following page 80.
    </div>
    <div class="reference">
      [2] The Combinatorial Object Server (2021). http://combos.org.
    </div>
    <div class="reference">
      [3] Kruchinin, D.; Kruchinin, V.; Shablya, Y. Method for Obtaining Coeff-
      cients of Powers of Bivariate Generating Functions. Mathematics 2021, 9,
      428. https://doi.org/10.3390/math9040428
    </div>
    <div class="reference">
      [4] Kruchinin, D.V., Kruchinin, V.V. Application of a composition of
      generating functions for obtaining explicit formulas of polynomials (2013)
      Journal of Mathematical Analysis and Applications, 404 (1), pp. 161-171.
    </div>
    <div class="reference">
      [5] Kruchinin, D.V., Kruchinin, V.V. Explicit formulas for some
      generalized polynomials (2013) Applied Mathematics and Information
      Sciences, 7 (5), pp. 2083-2088.
    </div>
    <div class="reference">
      [6] V. V. Kruchinin and D. V. Kruchinin, Composita and its properties, J.
      Analysis and Number Theory 2 (2014), 1-8.
    </div>
    <div class="reference">
      [7] V. V. Kruchinin and D. V. Kruchinin, A Method for Obtaining Generating
      Function for Central Coeffcients of Triangles Journal of Integer
      Sequences, Vol. 15 (2012), Article 12.9.3
    </div>
    <div class="reference">
      [8] V. V. Kruchinin and D. V. Kruchinin A Generating Function for the
      Diagonal T2n,n in Triangles Journal of Integer Sequences, Vol. 18 (2015),
      Article 15.4.6
    </div>
    <div class="reference">
      [9] D. V. Kruchinin On solving some functional equations Advances in
      Difference Equations, Vol. 1 (2015), 1687-1847.
      doi:10.1186/s13662-014-0347-9
    </div>
    <div class="reference">
      [10] DMITRY V. KRUCHININ and VLADIMIR V. KRUCHININ. (2019). Explicit
      formula for reciprocal generating function and its application. Advanced
      Studies in Contempo- rary Mathematics, 29(3), 365-372.
    </div>
    <div class="reference">
      [11] (Ira M.). - A combinatorial proof of the multivariable Lagrange
      inversion formula. Jour- nal of Combinatorial Theory. Series A, vol. 45,
      n◦ 2, 1987, pp. 178-195.
    </div>
    <div class="reference">
      [12] Clark Kimberling Path-counting and Fibonacci numbers, Fib. Quart. 40
      (4) (2002) 328-338,
    </div>
    <div class="reference">
      [13] Kruchinin, D., Kruchinin, V., Shablya, Y.On some properties of
      generalized Narayana numbers (2021) Quaestiones Mathematicae. DOI:
      10.2989/16073606.2021.1980448
    </div>
    <div class="reference">
      [14] Stanley, Richard P. (2015), Catalan numbers. Cambridge University
      Press, ISBN 978- 1-107-42774-7.
    </div>
    <div class="reference">
      [15] Kruchinin, Dmitry Kruchinin, Vladimir Shablya, Yuriy Shelupanov,
      Alexander. (2019). Explicit formulas for the Eulerian numbers of the
      second kind. AIP Conference Pro- ceedings. 2116. 100008.
      10.1063/1.5114084.
    </div>
  </div>
 Лаборатория алгоритмов и технологий исследования дискретных структур (ЛАТИДС) кафедры КСУП Сотрудники Лаборатории алгоритмов и технологий исследования дискретных структур О проекте Алина Полина Сергеевна Уже есть учётная запись? Методика использования Вы уверены, что хотит удалить Пирамиду Автор Просмотреть пирамиды По таблице данных Отменить Кандидат физико-математических наук Кандидат технических наук, старший научный сотрудник Коэффициенты $k$-ой степени композиции производящих функций Коэффициенты $k$-ой степени производящей функции решения функционального
              уравнения Коэффициенты $k$-ой степени обратной производящей функции Коэффициенты $k$-ой степени взаимной производящей функции Коэффициенты $k$-ой степени произведения производящих функций Коэффициенты $k$-ой степени суммы производящих функций Условие Подтвердите удаление Введите пароль ещё раз Скопировать Дарижапов Артём Батоевич Таблица данных Коэффициенты разложения Разложение композиции Стандартный Стандартный: 
    аттрибуты пирамиды 
        порядковый номер, 
        производящая функция, 
        явная формула,
    аттрибуты пользователя 
        имя пользователя;
По таблице данных:
    аттрибуты пирамиды
         таблица данных (находится на странице пирамиды). Удалить пирамиду Обозначения Доктор технических наук, доцент Пароли не совпадают Нет учётной записи? Электронная почта Редактировать профиль Редактировать пирамиду Редактировать профиль Ошибка Треугольник Эйлера (числа Эйлера первого рода) Примеры Явная формула Экспорт Экспортировать в LaTeX Экспортировать в Maxima Выражение Особенности данной энциклопедии Числа Фибоначчи Треугольник Фина Узнать, для чего нужна данная энциклопедия Нахождение явных выражений для разложения функций вида Нахождение явных выражений для разложения функций вида Нахождение явных выражений для разоложения композиции производящих функций
          многих переменных Нахождение взаимных производящих функций Нахождение коэффициентов обратных производящих функций Нахождение композици логарифмических функций и их производных Нахождение производящей функции для явного выражения коэффициентов Имя функции Переменные функции Производящая функция Производящая функция для чисел Эйлера второго порядка Производящая функция для диагонали Получение коэффициентов функции Перейти к методике использования Посмотреть информацию Перейти к пирамидам Группа ГПО Заведующий лабораторией Главная Как создавалась энциклопедия Тождество для гармнических чисел Язык интерфейса Неверно введён адрес электронной почты Ключевые слова Концевая Кристина Анатольевна Корнеева Юлия Андреевна  Кручинин Дмитрий Владимирович Кручинин Владимир Викторович Сотрудники ЛАТИДС Ведущий научный сотрудник Узнать подробнее о создателях Войти Выйти Получение коэффициентов степеней производящих функций одной
          переменной Получение явны выражений композиции производящих функций одной
          переменной Получение явных выражений композиции производящих функций двух переменных На нашем сайте вы можете Страница Пароль Перминова Мария Юрьевна Предпросмотр В разработке данного сайта и его содержимого принимают участие Пирамида Список пирамид Источники Связанные пирамиды Запомнить меня Сохранить изменения Поиск Поиск пирамид Тип поиска Поиск... Шабля Юрий Васильевич Зарегистрироваться К сожалению, такой страницы не существует. Вы можете попробовать вернуться на Студенты ТУСУР - участники Группового проектного обучения Методика использования для энциклопедии Данная пирамида некорректна. Она будет исправлена в скором времени Томский Государственный Университет Систем Управления и Радиоэлектроники Попробуйте вернуться на Загрузить изображение профиля Загрузить пирамиду Загруженный файл Пользователь с таким адресом электронной почты уже существует. Пользователь с таким именем уже существует. Имя пользователя Имя пользователя или Электронная почта Какие задачи решает данная энциклопедия Зачем нужна еще одна энциклопедия по математике Зачем нужны производящие функции Ваш поисковый запрос и исследовать пирамиды. и выполнить новый поисковый запрос не соотвествует ни одной записи главную страницу или Результаты по поиску 