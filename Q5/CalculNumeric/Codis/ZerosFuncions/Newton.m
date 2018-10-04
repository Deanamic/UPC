function [e, It] = Newton(y, Tol)
%NEWTON Uses Newton Method to calculate a 
%   Detailed explanation goes here

It = 1;
e(1) = 100;
while e(It) > Tol
    DFy = numericalDerivative(F,y); % avaluacio de la derivada numerica de F
    HFy = numericalHessian(F,y);    % avaluacio de la Hessiana numerica de F
    
    curY = y - HFy\DFy;
    
    e(It+1) = norm(curY-y)/norm(curY);
    It = It + 1;
    y = curY;
end


