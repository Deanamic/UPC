function deriv = DerivadaAproximada(Angle, Aval, eps)

Aval2 = distancia(Angle + eps) - 500;
deriv = (Aval2 - Aval)/eps;