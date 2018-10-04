a = -1;
b = 1;
m = [6];
reprpts = 500;
xr = linspace(a, b, reprpts);
%f = @(x) 1./(1+25*x.^2);
f = @(x) cos(2*pi.*x).*sin(pi.*x);

original = f(xr);

figure(03)
plot(xr, original, 'DisplayName', 'Original');

% Versio Legendre
for i = 1:length(m)
    A = zeros(m(i)+1, m(i)+1);
    for j = 1:m(i)+1
        for k = j:m(i)+1
            A(j, k) = integral(@(x) legendreP(j-1, x).*legendreP(k-1, x), -1, 1);
            A(k, j) = A(j, k);
        end
    end
    b = zeros(m(i)+1, 1);
    for j = 1:m(i)+1
        b(j) = integral(@(x) legendreP(j-1, x).*f(x), -1, 1);
    end
    c = A\b;
    interpolat = zeros(1, length(xr));
    for j = 0:m(i)
        interpolat = interpolat + c(j+1)*legendreP(j, xr);
    end
    figure(03)
    hold on
    plot(xr, interpolat, 'DisplayName', strcat('Legendre m=', num2str(m(i))));
    hold off
end
% Residu de Lagrange: f^(n+1)(\mu(x))/(n+1)!*L(x), L(x) = (x-x_0)...(x-x_n)
% Els splines lineals C0 tenen converg?ncia quadr?tica en la mida del
% subinterval: |R(x)| < 1/8*|f''(mu)|h_i^2
legend('show');