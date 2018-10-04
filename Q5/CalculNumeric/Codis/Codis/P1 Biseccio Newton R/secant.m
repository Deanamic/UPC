function [x1, errors] = secant(x0, x1, niter, tolx, toly)
    fprintf('Mètode de la secant. Interval [%e, %e]:\n', x0, x1);
    errors = zeros(1, niter+1); 
    for i = 0:niter
        x0c = x1;
        x1 = x1-f1(x1)*(x1-x0)/(f1(x1)-f1(x0));
        x0 = x0c;
        r = abs((x1-x0)/x1);
        ry = abs((f1(x1)-f1(x0))/f1(x1));
        errors(i+1) = r;
        if r < tolx || ry < toly
            break;
        end
        errors(i+1) = r;
        fprintf('Aproximació %d: x = %e, y = %e, r = %e\n', i, x0, f1(x0), r);
    end
    fprintf('\n');
    %plot(0:niter, log(errors));
end

