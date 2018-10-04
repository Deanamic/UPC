function [x, errors] = whittaker(x, m, niter, tolx, toly)
    fprintf('Mètode de Whittaker. Aproximació inicial %e, m = %d:\n', x, m);
    errors = zeros(1, niter+1); 
    for i = 0:niter
        oldx = x;
        x = x-f1(x)/m;
        r = abs((oldx-x)/x);
        ry = abs((f1(oldx)-f1(x))/f1(x));
        errors(i+1) = r;
        if r < tolx || ry < toly
            break;
        end
        fprintf('Aproximació %d: x = %e, y = %e, r = %e\n', i, oldx, f1(oldx), r);
    end
    fprintf('\n');
    %plot(0:niter, log(errors));
end