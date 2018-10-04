function [x,Y] = Euler(f, a, b, y0, nsteps)
Y(:,1) = y0;
h = (b-a)/nsteps;
x = linspace(a, b, nsteps + 1);

for i = 1:nsteps
    Y(:,i+1) = Y(:,i) + h*f(x(i), Y(:,i));
end