function res = P2newton(x0, a1, a2, a3, a4, beta, tol)
format long;

avalx0 = P2avalua(x0, a1, a2, a3, a4, beta);

while abs(avalx0) > tol
    x0 = x0 - avalx0/P2derivada(x0, a1, a4, beta);
    avalx0 = P2avalua(x0, a1, a2, a3, a4, beta);
end

res = x0;
endfunction


