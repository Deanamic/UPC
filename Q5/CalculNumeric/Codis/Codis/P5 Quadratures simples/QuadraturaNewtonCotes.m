function [w] = QuadraturaNewtonCotes(x, a, b)
%Per a calcular valors exactes d'integrals.
integral(f,a,b);
%Tots integren amb n+1 punts.
%Errors:
% - Newton-Cotes:
%     - n senar: C*h^(n+2) f^(n+1)(mu)
%     - n parell: C*h^(n+3) f^(n+2)(mu)  N+2!
% - Composta Trapezi: E = -(b-a)^3/(12*m^2) f^2(mu)
% - Composta Simpson: E = -(b-a)^5/(2880*m^4) f^4(mu)
    n=length(x)-1;
    A = fliplr(vander(x))';
    B = zeros(n+1, 1);
    % sistema Aw = B, w pesos
    
    for i = 1:n+1
        B(i) = integral(@(x) x.^(i-1), a, b);
    end
    w = A\B;
end