a = -1;
b = 1;
n = [2, 4, 6, 8];
reprpts = 500;

xr = linspace(a, b, reprpts);
original = 1./(1+25*xr.^2);

figure(01)
plot(xr, original, 'DisplayName', 'Original');

for i = 1:length(n)
    x = linspace(a, b, n(i)+1);
    fa = 1./(1+25*x.^2);
    p = polyfit(x, fa, n(i));
    interpolat = polyval(p, xr);
    figure(01)
    hold on
    plot(xr, interpolat, 'DisplayName', strcat('Interpolat n+1=', num2str(n(i)+1)));
    hold off
end
legend('show');