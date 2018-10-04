g = 9.81;
Cd = 0.65;
b = 0.2;
A = 5*10;
f=@(x,y) -2/3/A*Cd*b*sqrt(2*g)*y^(3/2); a=0; b=120;  y0=0.75;

% Solucio amb el metode d'Euler
npassos=4;
[x,Y]=Euler(f,[a,b],y0,npassos);
% figure(2), plot(x,Y,'-*'), title('Euler')
% Resposta: cota d'aigua en passar 2'
y120a = Y(end)

% Solucio amb el metode de Runge-Kutta de 4t ordre
npassos=1;
[x,Y]=RungeKutta4(f,[a,b],y0,npassos);
%figure(2), plot(x,Y,'-*'), title('Euler')
% Resposta: cota d'aigua en passar 2'
y120b = Y(end)

% Error de les aproximacions
[xe,Ye]=ode45(f,[a,b],y0);
y120 = Ye(end); % Nom?s t? 3 x.s.!
errA = abs(y120a-y120) % Nom?s caldria usar 3 x.s.
errB = abs(y120b-y120) % Nom?s caldria usar 3 x.s.
% Observaci?: m?s precisi? amb RK amb el mateix cost computacional
% Aixo es perque ordre de RK:   s,  si s <= 4; s-1 o s-2, si s > 4.

% Quants passos de Euler calen per a una soluci? igual de bona que RK4?
% i.e., m* tal que E_{m*} \sim 0.001?
% Sabem que E_m = c/m^q, q ordre, en aquest cas q = 1
% Donat que E_4 = 0.03 = c/4 => c = 4*0.03 = 0.12
% Per tant, m* = c/E_{m*} = 0.12/0.001 = 120

% Extra: Grafica de log10(abs(error)) en funcio de log10(avaluacions de f)
npassos = 1:10;
errorE = zeros(1, length(npassos));
errorRK = zeros(1, length(npassos));
for i = 1:length(npassos)
    [x1,Y1]=Euler(f,[a,b],y0,npassos(i));
    [x2,Y2]=Euler(f,[a,b],y0,npassos(i));
    errorE(i) = abs(Y1(end)-y120);
    errorRK(i) = abs(Y2(end)-y120);
end
figure(3), plot(log10(npassos),log10(abs(errorE)),'b-*',log10(4*npassos),log10(abs(errorRK)),'r-*'), title('log10(abs(error)) vs log10(avaluacions f)'), legend('Euler', 'Runge-Kutta')