function Angle = Secant(Angle0, Angle1)
format long;

convergence = 0;
k = 0;

while (convergence == 0 && k < 100)
    avalx1 = distancia(Angle1) - 500;
    avalx0 = distancia(Angle0) - 500;
    AngleAux = Angle1 - avalx1*(Angle1 - Angle0)/(avalx1 - avalx0);
    convergence = norm(Angle1 - AngleAux)/AngleAux < 1.e-6;
    Angle0 = Angle1;
    Angle1 = AngleAux;
    k = k + 1;
end

Angle = Angle1;