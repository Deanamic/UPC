fprintf("Avaluem els dos metodes\n");
interval = [4,8,16,32,64,128,256,512,1024,2048,4096,8192];
f = @(x) sin(exp(2*x));
value = integral(f, 0, 2);
for i = 1:12
    valTrapezi(i) = Trapezi(f, 0, 2, interval(i));
    eTrapezi(i) = abs(value - valTrapezi(i));
    valSimpson(i) = Simpson(f, 0, 2, interval(i));
    eSimpson(i) = abs(value - valSimpson(i));
end

figure(1)
plot(log2(interval+1), log2(eTrapezi), 'r+-', log2(2*interval+1), log2(eSimpson), 'b*-')
grid minor;
leg = legend('Metode del Trapezi', 'Quadratura de Simpson');
leg.FontSize = 15;

xlabel('log2(Nombre d''avaluacions de la funcio)');
ylabel('log2(Error Absolut)');

fprintf("Si suposem que l'error es decreixent, podem fer una dicotomica per trobar\n el minim m pel metode del trapezi tal que l'error absolut es menor a 1e-6\n");
l = 2047;
r = 4096;
while l + 1 < r
    m = floor((l+r)/2);
    err = abs(Trapezi(f, 0, 2, m) - value);
    if(err < 1e-6) r = m;
    else l = m;
    end
end
fprintf("Obtenim m = %d\n", r);

figure(2)
plot(log10(interval+1), log10(eTrapezi), 'r+-')
grid minor;
leg = legend('Metode del Trapezi');
leg.FontSize = 15;
xlabel('log10(Nombre d''avaluacions de la funcio)');
ylabel('log10(Error absolut)');

fprintf("Si suposem que l'error es decreixent, podem fer una dicotomica per trobar\n el minim m per la quadratura de Simpson tal que l'error absolut es menor a 1e-6\n");
l = 127;
r = 512;
while l + 1 < r
    m = floor((l+r)/2);
    err = abs(Simpson(f, 0, 2, m) - value);
    if(err < 1e-6) r = m;
    else l = m;
    end
end
fprintf("Obtenim m = %d\n", r);

figure(3)
plot(log10(2*interval+1), log10(eSimpson), 'b*-')
grid minor;
leg = legend('Quadratura de Simpson');
leg.FontSize = 15;
xlabel('log10(Nombre d''avaluacions de la funcio)');
ylabel('log10(Error absolut)');


figure(4)
[V, P] = SimpsonAdaptat(f, 0, 2, (1e-3)/2);
plot(P, f(P), 'b*-',P, zeros(length(P),1), '.')
length(P)
grid minor;
leg = legend('Quadratura de Simpson Adaptada');
leg.FontSize = 15;
xlabel('x');
ylabel('sin(exp(2x))');


figure(5)
[V, P] = SimpsonAdaptat(f, 0, 2, (1e-6)/2);
plot(P, f(P), 'b*-', P, zeros(length(P),1), '.')
grid minor;
leg = legend('Quadratura de Simpson Adaptada');
leg.FontSize = 15;
xlabel('x');
ylabel('sin(exp(2x))');
