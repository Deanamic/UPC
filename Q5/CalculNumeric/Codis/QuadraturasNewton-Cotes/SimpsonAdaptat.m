function [I,P] = SimpsonAdaptat(f, l, r, eps)
%L'error maxim es (r-l)*eps
I = Simpson(f, l, r, 1);
S = Simpson(f, l, (l+r)/2, 1) + Simpson(f, (l+r)/2, r, 1);
P = [l,r];

E = abs(I - S);
if E > eps*(r-l)
    [L1, P1] = SimpsonAdaptat(f, l, (l+r)/2, eps);
    [R1, P2] = SimpsonAdaptat(f, (l+r)/2, r, eps);
    I = L1 + R1;
    P = [P1 P2];
    P = unique(P);
end
end
