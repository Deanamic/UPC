load corba
val = integra(100, b);
h = integra(100, b)/34;
x(1) = 1;
y(1) = a;
ant = 0.4;
m = 100;
cont = 2;
for i = h:h:val-h
    ant = newton(ant, i, m)
    x(cont) = cont;
    y(cont) = ant;
    cont = cont+1;
end
x(cont) = cont;
y(cont) = b;
y
