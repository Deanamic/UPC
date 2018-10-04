param a;
param b;
param p;
param n;
param tol;


#cas on la Y es fixada
##Farem la distribucio segons p, p = 1 uniforme, p > 1 concentrat al origen, p < 1 concentrat al final
param y {i in 0..n} := b*(i/n)^p;

#Variables
var x {0..n};


#FUNCIO OBJECTIU
minimize Mapping:
   1/sqrt(2*9.8)*(sum {i in 1..n} (sqrt(((x[i]-x[i-1])^2+(y[i]-y[i-1])^2)/max(tol,y[i-1]))));

#RESTRICCIONS
subject to start : x[0]= 0;

subject to end : x[n] = a;
#Necessitem que f^-1 sigui injectiva
subject to injective{i in 1..n}: x[i] >= x[i-1] + tol;
