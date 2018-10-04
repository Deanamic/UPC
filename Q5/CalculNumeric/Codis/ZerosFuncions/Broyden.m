function [e, It] = Broyden(y, Tol)
%NEWTON Uses Newton Method to calculate a 
%   Detailed explanation goes here

It = 1;
e(1) = 100;
Sk = eye(size(y));
while e(It) > Tol  
    DFy = numericalDerivative(F,y);
    Dxk =  -Sk\DFy;
    curY = y + Dxk;
    Fy = F(curY);
    DFy = numericalDerivative(F,curY);
    Sk = Sk + DFy * (Dxk/(norm(Dxk))^2)';
 
    e(It+1) = norm(curY-y)/norm(curY);
    fprintf(' Iteracio %2d: Distorsio = %2.7f, Error relatiu y = %4.2e\n',k,Fy,relErr(k+1))
    k = k+1; yk = ykp1;
    It = It + 1;
    y = curY;
end