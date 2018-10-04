function res = P4newton(x0, tol)
format long;

avalx0 = P4avalua(x0);

while abs(avalx0) > tol
    x0 = x0 - avalx0/P4derivada(x0);
    avalx0 = P4avalua(x0);
end

res = x0;
endfunction