function [c] = BaseChebyshev(f, m)
%BASELEGENDRE Return the Base of the Legendre Polynomial
%   It takes 2 arguments, the funtion to approximate and the degree of the
%   polynomial
% It return an array c with the m coefficients

a = -1;
b = 1;
reprpts = 100;
xr = linspace(a, b, reprpts);
%f = @(x) 1./(1+25*x.^2);
original = f(xr);

A = zeros(m+1, m+1);
for j = 1:m+1
    A(j, j) = integral(@(x) 1./sqrt(1-x.^2).*chebyshevT(j-1, x).*chebyshevT(j-1, x), -1, 1);
end
b = zeros(m+1, 1);
for j = 1:m+1
    b(j) = integral(@(x) 1./sqrt(1-x.^2).*chebyshevT(j-1, x).*f(x), -1, 1);
end
c = A\b;
interpolat = zeros(1, length(xr));
for j = 0:m
    interpolat = interpolat + c(j+1)*chebyshevT(j, xr);
end

figure(03)
plot(xr, original, 'DisplayName', 'Original');
hold on
plot(xr, interpolat, 'DisplayName', strcat('Legendre m=', num2str(m)));

% Residu de Lagrange: f^(n+1)(\mu(x))/(n+1)!*L(x), L(x) = (x-x_0)...(x-x_n)
% Els splines lineals C0 tenen converg?ncia quadratica en la mida del
% subinterval: |R(x)| < 1/8*|f''(mu)|h_i^2
legend('show');

end

