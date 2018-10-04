function [x, y, It] = Bisection(F, a, b, Tol)
%BISECTION uses the method of Bisection to find a root of F
% it takes 4 arguments
% The funtion F, two initial points with different signs and the Tolenrance
% It return 4 values, the points considered, its evaluation,and the number
% of Iterations

It = 1;

if F(a) < 0
    c = a;
    a = b;
    b = c;
end

while abs(b-a) > Tol
    x(It) = (b-a)/2;
    y(It) = F(x(It));
    if y(It)> 0
        a = x(It);
    else
        b = x(It);
    end
    It = It + 1;
end

