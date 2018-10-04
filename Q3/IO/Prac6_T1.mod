param a;
param b;
param p;
param n;
param tol;


#cas on la X es fixada
##Farem la distribucio segons p, p = 1 uniforme, p > 1 concentrat al origen, p < 1 concentrat al final
param x {i in 0..n} := a*(i/n)^p;

#VARIABLES
var y {0..n};

#FUNCIO OBJECTIU
minimize Mapping:
   1/sqrt(2*9.8)*(sum {i in 1..n} (sqrt(((x[i]-x[i-1])^2+(y[i]-y[i-1])^2)/max(tol,y[i-1]))));

#RESTRICCIONS
subject to start : y[0]= 0;

subject to end : y[n] = b;
