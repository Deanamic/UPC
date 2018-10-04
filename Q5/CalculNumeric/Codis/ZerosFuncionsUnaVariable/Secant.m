function [x, y, e, It] = Secant(F, a, b, Tol)
%NEWTON Uses Secant Method to calculate the 0 of a funciton F
% return [x,y,e,It] the points of each iteration, its value and the relative
% error at each step and the number of iterations
% It takes 4 arguemts
% The funtion F, 2 initial points and the tolerance

x(1) = a; x(2) = b;
y(1) = F(x(1)); y(2) = F(x(2));
It = 2;

while abs(y(It)) > Tol
    x(It + 1) = x(It) - (y(It)*(x(It) - x(It - 1))/(y(It) - y(It - 1)));
    y(It + 1) = F(x(It + 1));
    e(It + 1) = abs((x(It + 1) - x(It))/x(It + 1));
    It = It + 1;
end

It = It - 1;

