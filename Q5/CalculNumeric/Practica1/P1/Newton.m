function Angle = Newton(AngleInicial)
format long;

convergence = 0;
k = 0;
Angle = AngleInicial;

while (convergence == 0 && k < 100)
    Aval = distancia(Angle) - 500;
    NouAngle = Angle - Aval/DerivadaAproximada(Angle, Aval, 1.e-7);
    convergence = norm(Angle - NouAngle)/NouAngle < 1.e-6;
    Angle = NouAngle;
    k = k+1;
end