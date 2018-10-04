function d2S = calculaCurvaturesSplineNatural(x,y)
    % Calcula les curvatures d'un spline natural
    % De fet, calcula les curvatures d'un spline cubic C2
    % (formulació en curvatures): imposa continuitat de la derivada
    % (desconeguda) i així surten valors de curvatura determinats
    % Si no volem el natural, canviar les condicions d2S inicial i final
    n = length(x)-1;
    A = zeros(n-1);
    b = zeros(n-1, 1);
    for i = 1:n-1
        h = x(i+2)-x(i+1);
        hold = x(i+1)-x(i);
        t = y(i+2)-y(i+1);
        told = y(i+1)-y(i);
        lambda = h/(h+hold);
        mu = hold/(h+hold);
        d = 6/(h+hold)*(t/h-told/hold);

        if(i > 1)
            A(i, i-1) = mu;
        end
        A(i, i) = 2;
        if(i < n-1)
            A(i, i+1) = lambda;
        end
        b(i) = d;
    end
    d2S = [0; A\b; 0];
end
