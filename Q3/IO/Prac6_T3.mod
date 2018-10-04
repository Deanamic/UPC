param a;
param b;
param n;
param tol;


#cas on la x,y son variables
var y {0..n};
var x {0..n};

#FUNCIO OBJECTIU
minimize Mapping:
   1/sqrt(2*9.8)*(sum {i in 1..n} (sqrt(((x[i]-x[i-1])^2+(y[i]-y[i-1])^2)/max(tol,y[i-1]))));

#RESTRICCIONS
subject to startx : x[0]= 0;
subject to endx : x[n] = a;
subject to injectivex {i in 1..n}: x[i] >= x[i-1] + tol;

subject to starty : y[0]= 0;
subject to endy : y[n] = b;
subject to injectivey{i in 1..n}: y[i] >= y[i-1] + tol;
