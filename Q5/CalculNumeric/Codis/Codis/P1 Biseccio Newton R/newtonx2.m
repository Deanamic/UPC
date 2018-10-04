function [x, errors] = newtonx2(x, niter, tolx, toly)
    % Recordatori: canviar f1 i fp!!
    % Versió millorada per a l'arrel doble!
    fprintf('Mètode de Newton. Aproximació inicial %e:\n', x);
    errors = zeros(1, niter+1); 
    for i = 0:niter
        oldx = x;
        x = x-2*f1(x)/fp(x);
        r = abs((oldx-x)/x);
        ry = abs((f1(oldx)-f1(x))/f1(x));
        errors(i+1) = r;
        fprintf('Aproximació %d:\t x = %e,\t y = %e,\t r = %e\n', i, oldx, f1(oldx), r);
        if r < tolx || ry < toly
            break;
        end
    end
    fprintf('\n');
    plot(0:niter, log(errors));
end

