function res = P2avalua(x, a1, a2, a3, a4, beta)
res = a1*cos(beta)/a2 - a1*cos(x)/a4 - cos(beta-x) + (a1*a1 + a2*a2 - a3*a3 +a4*a4)/(2*a2*a4);
endfunction

