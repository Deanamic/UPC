a = -1;
b = 1;
m = [2, 4, 6, 8];
n = 100;
reprpts = 500;
x = linspace(a, b, n+1);
xr = linspace(a, b, reprpts);
f = 1./(1+25*x.^2);
original = 1./(1+25*xr.^2);

figure(02)
plot(xr, original, 'DisplayName', 'Original');

for i = 1:length(m)
    % Opcio 1: plantejar equació
%     A = zeros(m(i)+1, m(i)+1);
%     for j = 1:m(i)+1
%         for k = j:m(i)+1
%             A(j, k) = sum((x.^(j-1)).*(x.^(k-1)));
%             A(k, j) = A(j, k);
%         end
%     end
%     b = zeros(m(i)+1, 1);
%     for j = 1:m(i)+1
%         b(j) = sum((x.^(j-1)).*f);
%     end
%     c = A\b;

    % Opcio 2: polyfit
    c = flip(polyfit(x, f, m(i)));
    interpolat = polyval(flip(c), xr);
    interpolatx = polyval(flip(c), x);
    figure(02)
    hold on
    plot(xr, interpolat, 'DisplayName', strcat('Mínims quadrats m=', num2str(m(i))));
    hold off
    fprintf('Per a m = %d, residu E = %e\n', m(i), sum((f-interpolatx).^2));
end
legend('show');