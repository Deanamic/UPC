function res = newton(aproxInicial, imatge, m)
format long;
convergence = 0;
k = 0;
x = aproxInicial;
F = @(y)(ava(y));
while (convergence == 0 && k < 100)
    Aval = integra(m, x) - imatge;
    NovaX = x - Aval/numericalDerivative(F, x);
    convergence = norm(x - NovaX)/NovaX < 1.e-6;
    fprintf('\nValor %2.10f, %2.10f, %2.10f, %2.10f, %2.10f\n',NovaX, integra(m,x), imatge, Aval, numericalDerivative(F, x));
    x = NovaX;
    k = k+1;
end

res = x;

