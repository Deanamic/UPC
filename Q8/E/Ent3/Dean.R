#Hello people, us passo aquí el meu codi. Està preparat per copiar, només heu de canviar les constants que vaig definint per les vostres. Si teniu algun dubte doncs mireu el meu enunciat. BTW no asseguro que estigui bé però bueno jo és el que enviaré. bss!


#---------------------------------------------------------------------------------------------------------#
options(digits = 20)
library(matlib)

#introdueixo els exponents de la funció de densitat, que varien segons la persona:
a = -1.3
c = -0.3




#------------------------APARTAT A ------------------------------------------------------------------------#
#Per resoldre el primer apartat, resoldrem un sistema d'equacions amb el qual trobarem lambda i eta, guardem
#primer els valors de les esperances:
ex = 2.42
eix = 0.52

#Resolem el sistema:
fl <- function(x){
  (ex*besselK(x,c))/besselK(x,c+1)
} 

feq <- function(x){
  res = ((fl(x))^2)*eix + ((2*c)/x)*fl(x) - ex
  return(res)
}

Alambda = uniroot(feq, interval = c(1,5), tol = 10^(-30))
Alambda = Alambda$root
Aeta = fl(Alambda)

#1
Alambda 

#2
Aeta 


#Calculem la varianÇa de Var(x), substituint en la fòrmula els valors obtinguts de 
#Alambda i Aeta:
Avar = -(Alambda/2)*(besselK(Alambda,c+1))^2 + (besselK(Alambda,c))*(c+1)*(besselK(Alambda,c+1))
Avar = Avar + (Alambda/2)*(besselK(Alambda,c))^2
Avar = Avar*((2*(Aeta^2))/Alambda)
Avar = Avar/((besselK(Alambda,c))^2)

#3
Avar 

#Calculem la variança de 1/X, var(1/x):
Avari = -((besselK(Alambda,c+1))^2)*((Alambda^2)/4) + (Alambda/2)*(besselK(Alambda,c))*(c+1)*(besselK(Alambda,c+1))
Avari = Avari - ((besselK(Alambda,c))^2)*(-((Alambda^2)/4) + c)
Avari = Avari/(((Alambda^2)*(Aeta^2)*((besselK(Alambda,c))^2))/4)

#4
Avari

#Calculem la covarianÇa de x, 1/x
Acov = (Alambda/2)*((besselK(Alambda,c))^2) - (Alambda/2)*(besselK(Alambda,c+1)^2)
Acov = Acov + (besselK(Alambda,c))*(besselK(Alambda,c+1))*c
Acov = Acov/((Alambda/2)*((besselK(Alambda,c))^2))

#5
Acov
#------------------------APARTAT A ------------------------------------------------------------------------#




#------------------------APARTAT B ------------------------------------------------------------------------#
#Estimació de lambda i eta pel mètode de la màxima versemblança:

#Primer guardem el valor de la suma de les x's i de la suma de les inverses:
n = 100;
mitx = 2.232818 
mitix = 0.541371 
sumx = n*mitx 
sumix = n*mitix 


#definim la funció de la -logversemblança de x = (lambda,eta):
lv <- function(x){
  res = -n*c*log(x[2]) -n*log(besselK(x[1],c))
  res = res - (x[1]/(2*x[2]))*sumx - ((x[1]*x[2])/2)*sumix
  return(-res)
}
?nlm
mv <- nlm(f = lv,p = c(3.8,2.3), ndigit = 20, steptol = 10^-7)

Blambda = mv$estimate[1]
Beta = mv$estimate[2]
lv(c(Blambda, Beta)) - lv(c(Blambda, numv))
#6
Blambda

#7
Beta

#Calculem la matriu d'informació de fisher: 

Bvar = -(Blambda/2)*(besselK(Blambda,c+1))^2 + (besselK(Blambda,c))*(c+1)*(besselK(Blambda,c+1))
Bvar = Bvar + (Blambda/2)*(besselK(Blambda,c))^2
Bvar = Bvar*((2*(Beta^2))/Blambda)
Bvar = Bvar/((besselK(Blambda,c))^2)

#8
n*Bvar

Bvari = -((besselK(Blambda,c+1))^2)*((Blambda^2)/4) + (Blambda/2)*(besselK(Blambda,c))*(c+1)*(besselK(Blambda,c+1))
Bvari = Bvari - ((besselK(Blambda,c))^2)*(-((Blambda^2)/4) + c)
Bvari = Bvari/(((Blambda^2)*(Beta^2)*((besselK(Blambda,c))^2))/4)

#9
n*Bvari 

Bcov = (Blambda/2)*((besselK(Blambda,c))^2) - (Blambda/2)*(besselK(Blambda,c+1)^2)
Bcov = Bcov + (besselK(Blambda,c))*(besselK(Blambda,c+1))*c
Bcov = Bcov/((Blambda/2)*((besselK(Blambda,c))^2))


#10
n*Bcov


#Definim la matriu d'informacio:
MI <- matrix(c(n*Bvar,n*Bcov,n*Bcov,n*Bvari),nrow=2,ncol=2)
#------------------------APARTAT B ------------------------------------------------------------------------#





#------------------------APARTAT C ------------------------------------------------------------------------#
IE1 = c(Bvar,Bcov)
IE2 = c(Bcov,Bvari)
CRE1 = IE1%*%inv(MI)%*%(t(t(IE1)))
CRE2 = IE2%*%inv(MI)%*%(t(t(IE2)))


#11
CRE1


#12
CRE2

t1 = (-Blambda/(2*Beta))
t2 = (-Blambda*Beta)/2


#13 
DIl = c(t2/(sqrt(t1*t2)), t1/(sqrt(t1*t2)))
CRl = DIl%*%inv((1/n)*MI)%*%(t(t(DIl)))
conf2 = 0.975
interval1a = -(qnorm(conf2,mean = 0, sd = 1))*(sqrt(CRl/n)) + Blambda  
interval1a
interval1b = (qnorm(conf2,mean = 0, sd = 1))*(sqrt(CRl/n)) + Blambda 
interval1b


#14
IN = c((1/2)*(1/sqrt(t2/t1))*t2, (1/2)*(1/sqrt(t2/t1))*(1/t1))
CRN = IN%*%inv((1/n)*MI)%*%(t(t(IN)))
interval2a = -(qnorm(conf2,mean = 0, sd = 1))*(sqrt(CRN/n)) + Beta 
interval2a
interval2b = (qnorm(conf2,mean = 0, sd = 1))*(sqrt(CRN/n)) + Beta
interval2b
#------------------------APARTAT C ------------------------------------------------------------------------#