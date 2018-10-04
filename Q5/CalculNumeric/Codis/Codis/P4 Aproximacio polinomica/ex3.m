a = -1;
b = 1;
m = [6];
reprpts = 500;
xr = linspace(a, b, reprpts);
f = @(x) cos(2*pi.*x).*sin(pi.*x);
original = f(xr);

figure(04)
plot(xr, original, 'DisplayName', 'Original');

% Versio Chebyshev
% Recuerrencia de polinomis ortog.: P_{i+1} = (a_i*x+b_i)*P_i + c_i*P_{-1}
% amb a_i: divisio dels coeficients principals de P_{i+1} i P_i
%   b_i = -ai*<xPi(x), Pi(x)>/<Pi(x), Pi(x)>
%   c_i = -ai*<xPi(x), P{i-1}(x)>/<P{i-1}(x), P{i-1}(x)>
for i = 1:length(m)
    A = zeros(m(i)+1, m(i)+1);
    for j = 1:m(i)+1
        for k = j:m(i)+1
            A(j, k) = integral(@(x) 1./sqrt(1-x.^2).*x.^(j+k-2), -1, 1);
            A(k, j) = A(j, k);
        end
    end
    b = zeros(m(i)+1, 1);
    for j = 1:m(i)+1
        b(j) = integral(@(x) 1./sqrt(1-x.^2).*x.^(j-1).*f(x), -1, 1);
    end
    c = A\b;
    interpolat = zeros(1, length(xr));
    for j = 0:m(i)
        interpolat = interpolat + c(j+1)*xr.^(j);
    end
    figure(04)
    hold on
    plot(xr, interpolat, 'DisplayName', strcat('Chebyshev m=', num2str(m(i))));
    hold off
end
% Desigualtat de Bessel: \sum c_j^2 ||Y_j(x)||^2 < ||f||^2 (amb desigualtat
% no estricta)

legend('show');