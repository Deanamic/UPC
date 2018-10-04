function [x,Y] = RungeKutta4( f, v, y0, npassos )
    Y = zeros(length(y0), npassos+1);
    a = v(1);
    b = v(2);
    x = linspace(a, b, npassos+1);
    h = (b-a)/(npassos);
    Y(:, 1) = y0;
    for i = 1:npassos
        k1 = f(x(i), Y(:, i));
        k2 = f(x(i)+h/2, Y(:, i)+h/2*k1);
        k3 = f(x(i)+h/2, Y(:, i)+h/2*k2);
        k4 = f(x(i)+h, Y(:, i)+h*k3);
        Y(:, i+1) = Y(:, i) + h/6*(k1+2*k2+2*k3+k4);
    end
end

