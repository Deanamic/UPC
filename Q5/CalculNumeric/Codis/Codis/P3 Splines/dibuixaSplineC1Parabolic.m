function [xS,yS,coeficients]=dibuixaSplineC1Parabolic(x,y)
    xS = []; yS = []; coeficients = [];
    x01 = [0:1/20:1]; %20 subintervals a cada interval

    h=x(2:end)-x(1:end-1);
    t=y(2:end)-y(1:end-1);
    % Aproximació de la derivada per al primer punt
    fp = [(y(2)-y(1))/(x(2)-x(1))];
        
    for i=1:length(x)-1
        c = y(i);
        b = fp(i);
        a = 1/(h(i)^2)*(t(i)-b*h(i));
        xs = x(i)+x01*h(i); %valors de x a l'interval
        ys = a*(xs-x(i)).^2 + b*(xs-x(i)) + c;
        fp = [fp 2*a*h(i)+b];
        xS = [xS xs]; yS = [yS ys]; coeficients=[coeficients; a b c];
    end
end