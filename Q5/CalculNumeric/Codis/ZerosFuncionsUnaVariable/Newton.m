function [x, y, e, It] = Newton(F, dF, InitialX, Tol)
%NEWTON Uses Newton Method to calculate the 0 of a funciton F
% return [x,y,e, It] the points of each iteration, its value and the relative
% error at each step and the number of iterations
% It takes 4 arguemts
% The funtion F, its derivative, an initial point and the tolerance

x(1) = InitialX;
y(1) = F(x(1));
It = 1;

while abs(y(It)) > Tol
    x(It + 1) = x(It) - y(It)/dF(x(It));
    y(It + 1) = F(x(It + 1));
    e(It + 1) = abs((x(It + 1) - x(It))/x(It + 1));
    It = It + 1;
end

