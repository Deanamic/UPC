function [x, errors] = newton(x, niter, tolx, toly)
    % Recordatori: canviar f1 i fp!!
    % Quan té arrel doble, comportament lineal; arrel simple, sota 2^{-n}
    % Comprovar q xifres significatives: r_k <= 1/2*10^{-q}
    fprintf('Mètode de Newton. Aproximació inicial %e:\n', x);
    errors = zeros(1, niter+1); 
    for i = 0:niter
        oldx = x;
        x = x-f1(x)/fp(x);
        r = abs((oldx-x)/x);
        ry = abs((f1(oldx)-f1(x))/f1(x));
        errors(i+1) = r;
        if r < tolx || ry < toly
            break;
        end
        fprintf('Aproximació %d: x = %e, y = %e, r = %e\n', i, oldx, f1(oldx), r);
    end
    fprintf('\n');
    plot(0:niter, log(errors));
end

