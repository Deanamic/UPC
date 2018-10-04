% Busquem una bona aproximacio inicial
x0 = [0,0,0]; % Random
x0 = fsolve(@f1, x0);

niter = 10;
epsilon = 1e-10;
x0 = [0,0,0];
[x1, e1] = NewtonOrig(x0, niter);
[x2, e2] = NewtonMod(x0, niter);
[x3, e3] = NewtonOrigNum(x0, niter, epsilon);

figure(01)
plot(1:niter, log(e1), 'r');
hold on
plot(1:niter, log(e2), 'b');
plot(1:niter, log(e3), 'g');
hold off

