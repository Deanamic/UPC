function [x,Y] = Euler( f, v,y0,npassos )
    Y = zeros(length(y0), npassos+1);
    a = v(1);
    b = v(2);
    x = linspace(a, b, npassos+1);
    h = (b-a)/(npassos);
    Y(:, 1) = y0;
    for i = 2:npassos+1
        Y(:, i) = Y(:, i-1) + h*f(x(i), Y(: ,i-1)');
    end
end

