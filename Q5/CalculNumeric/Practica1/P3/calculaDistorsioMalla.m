function distorsioMalla = calculaDistorsioMalla(X,T)

A = [1  -sqrt(3)/3
     0 2*sqrt(3)/3];
suma = 0;
numElements = size(T,1);
for e = 1:numElements
   Xe = X(T(e, :), :);
   D = [Xe(2, :) - Xe(1, :); Xe(3, :) - Xe(1, :)]' * A;
   ntri = (norm(D,'fro')^2)/(2*det(D));
   suma = suma + ntri^2;
end

distorsioMalla = sqrt(suma);
return;