function Angle = Biseccio(Angle0, Angle1)

format long;
convergence = 0;
k = 0;

f1 = distancia(Angle0) - 500;
f2 = distancia(Angle1) - 500;
if f1 * f2 > 0
    error("Invalid starting interval")
end

if f1 > 0
    Aux = Angle0;
    Angle0 = Angle1;
    Angle1 = Aux;
end


while (convergence == 0 && k < 100)
    AngleAux = (Angle0 + Angle1)/2;
    aval = distancia(AngleAux) - 500;
    if (aval >= 0) Angle1 = AngleAux;
    else Angle0 = AngleAux;
    end
    convergence = norm(Angle1 - Angle0) < 1.e-6;
    k = k + 1;
end

Angle = Angle1;
