function [x, error] = NewtonMod(x0, niter)
    fprintf('Mètode de Newton modificat, x0 = [%e, %e, %e]\n', x0(1), x0(2), x0(3));
    error = zeros(1, niter);
    J = Jf1(x0);
    for i = 1:niter
        x1 = x0 - (J\f1(x0))';
        error(i) = norm((x1-x0))/norm(x1);
        fprintf('Iteració %d: x = [%e, %e, %e], error = %e\n', i, x1(1), x1(2), x1(3), error(i));
        x0 = x1;
    end
    x = x0;
    fprintf('\n');
end