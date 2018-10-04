% Aproximacio inicial o bé extrem inferior d'interval
a = 3;
% Extrem superior d'interval
b = 2;

% Toleràncies
tolx = 1e-12;
toly = 1e-12;

% Màxim d'iteracions
niter = 100;

[x1, e1] = biseccio(a, b, niter, tolx, toly);
[x2, e2] = newton(a, niter, tolx, toly);
[x3, e3] = secant(a, b, niter, tolx, toly);
[x4, e4] = whittaker(a, -26, niter, tolx, toly);

figure(01)
plot(0:20, log(e1), 'r-o')
hold on
plot(0:20, log(e2), 'b-o')
plot(0:20, log(e3), 'g-o')
plot(0:20, log(e4), 'y-o')
hold off

% Proves amb diferents m
[x4a, e4a] = whittaker(a, -26, niter, tolx, toly);
[x4b, e4b] = whittaker(a, -32, niter, tolx, toly);
[x4c, e4c] = whittaker(a, -20, niter, tolx, toly);
[x4d, e4d] = whittaker(a, 150, niter, tolx, toly);

figure(02)
plot(0:20, log(e4a), 'r-o')
hold on
plot(0:20, log(e4b), 'b-o')
plot(0:20, log(e4c), 'g-o')
plot(0:20, log(e4d), 'y-o')
hold off