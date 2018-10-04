function Iaprox=compostaGL(f,a,b,m,n)
    x = linspace(a,b,m+1); h=(b-a)/(m);
    Iaprox = 0;
    [z, w] = QuadraturaGauss(n);
    for i = 1:m
        a = x(i);
        b = x(i+1);
        Iaprox = Iaprox + sum((b-a)/2*w.*f((a+b)/2+(b-a)/2.*z)');
    end
    