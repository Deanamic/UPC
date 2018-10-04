% Objectius:
% - Entendre els conceptes basics dels metodes per a la resolucio numerica
% d'EDOs.
% - Implementar un metode per resoldre EDOs (metode d'Euler)
% - Comprovar experimentalment la convergencia d'un metode
%
% Tasques a fer:
% 1) Executar i mirar aquest script per veure com es pot resoldre el 
%    problema de valor inicial (PVI) amb la funcio de Matlab ode45
% 2) Implementar el metode d'Euler per a la resolucio del mateix PVI
%    Cal crear la funcio Euler amb els arguments d'entrada i sortida
%    especificats a aquest script. 
% 3) Dibuixar una grafica de log10(abs(error)) en funcio de log10(h), on l'error
%    s'evalua com la diferencia entre la solucio analitica i la solucio
%    numerica per x=2. Comprovar si l'ordre de convergencia coincideix amb
%    el teoric.
% Es proposa ara resoldre el PVI y''= -y, y(0)=1, y'(0)=0 per x en (0,T)
% 4) Reduir la EDO de segon ordre a un sistema d'EDOs de 1er ordre
%    Resoldre numericament el PVI amb el metode d'Euler per T=2*pi. Comprovar
%    la converg?ncia.
% 5) Amb h=0.01 resoldre el problema per T=10*pi,50*pi. ?s el m?tode
%    (absolutament) estable? 


% Resolucio de la EDO dy/dx = -y/(10x+1) per x en (0,1) 
% amb condicio inicial y(0)=1
f=@(x,y) -y/(10*x+1); a=0; b=2;  y0=1;

% Solucio amb funcions intrinseques de Matlab
[x,Y]=ode45(f,[a,b],y0);
figure(1), plot(x,Y,'-*'), title('ode45')

% Solucio amb el metode d'Euler
h=0.1;
npassos=ceil((b-a)/h); 
[x,Y]=Euler(f,[a,b],y0,npassos);
figure(2), plot(x,Y,'-*'), title('Euler')

% Ex3: Grafica de log10(abs(error)) en funcio de log10(h)
% Solucio analitica
yan = @(x) (10*x+1)^(-0.1);
h = [0.5, 0.25, 0.1, 0.05, 0.025, 0.01];
error = zeros(1, length(h));
for i = 1:length(h)
    npassos=ceil((b-a)/h(i)); 
    [x,Y]=Euler(f,[a,b],y0,npassos);
    error(i) = Y(end)-yan(b);
end
figure(3), plot(log10(h),log10(abs(error)),'-*'), title('log10(abs(error)) vs log10(h)')


% Ex4: PVI y''= -y, y(0)=1, y'(0)=0 per x en (0,T), amb T = 2*pi
f=@(x,y) [y(2), -y(1)]'; a=0; b=2*pi; y10=1; y20 = 0;
h=0.1;
npassos=ceil((b-a)/h); 
[x,Y]=Euler(f,[a,b],[y10,y20]',npassos);
figure(4), plot(x,Y(1, :),'-*'), title('Euler bidimensional')

% Ex4b: Convergència
yan = @(x) cos(x);
h = [0.5, 0.25, 0.1, 0.05, 0.025, 0.01];
error = zeros(1, length(h));
for i = 1:length(h)
    npassos=ceil((b-a)/h(i)); 
    [x,Y]=Euler(f,[a,b],[y10,y20]',npassos);
    error(i) = Y(1, end)-yan(b);
end
figure(5), plot(log10(h),log10(abs(error)),'-*'), title('log10(abs(error)) vs log10(h)')

% Ex5: h = 0.01, T1 = 10*pi, T2 = 50*pi
a = 0;
T = [10*pi, 50*pi];
h = 0.01;
%plot = zeros(length(T), npassos+1);
for i = 1:length(T)
    npassos=ceil((T(i)-a)/h); 
    [x,Y]=Euler(f,[a,T(i)],[y10,y20]',npassos);
    %plot(i, :) = Y(1, :);
    figure(6+i), plot(x,Y(1, :),'-', 'DisplayName', strcat('T=', num2str(T(i)))), title('Solucio per Euler'), legend('show')
end