function [x, errors] = biseccio(x, a, niter, tolx, toly)
    fprintf('Mètode de la bisecció. Interval [%e, %e]:\n', x, a);
    errors = zeros(1, niter+1); 
    for i = 0:niter
        oldx = x;
        x = (x+a)/2;
        r = abs((oldx-x)/x);
        ry = abs((f1(oldx)-f1(x))/f1(x));
        errors(i+1) = r;
        if r < tolx || ry < toly
            break;
        end
        fprintf('Aproximació %d: x = %e, y = %e, r = %e\n', i, oldx, f1(oldx), r);
        if f1(x)*f1(oldx) < 0
            a = oldx;
        end
        i = i+1;
    end
    fprintf('\n');
    %plot(0:niter, log(errors));
end