clear all; close all;
load malla1718 %X,T,Nint
format long;
figure(1),plotMesh(X,T), title('Malla inicial') 

% ===> IMPLEMENTAR la distorsio de malla a l'arxiu calculaDistorsioMalla.m <===
F = @(y)(calculaDistorsioMalla([reshape(y,Nint,2);X(Nint+1:end,:)],T));
fprintf('\nValor inicial de la distorsio: %2.6f\n',calculaDistorsioMalla(X,T))  

fprintf('\nBroyden...\n')
yk =  reshape(X(1:Nint,:),2*Nint,1);
k = 0; relErr = zeros(100,1); convergence = 0;
Sk = numericalHessian(F,yk);
%Sk = eye(28);
Fy = F(yk);

while(convergence==0 && k<500)
    %Fy = F(yk);
    
    DFy = numericalDerivative(F,yk);
    Dxk =  -Sk\DFy;
    ykp1 = yk + Dxk;
    Fy = F(ykp1);
    DFy = numericalDerivative(F,ykp1);
    Sk = Sk + DFy * (Dxk/(norm(Dxk))^2)';
 
    relErr(k+1) = norm(ykp1-yk)/norm(ykp1);
    convergence = relErr(k+1)<1.e-6;
    fprintf(' Iteracio %2d: Distorsio = %2.7f, Error relatiu y = %4.2e\n',k,Fy,relErr(k+1))
    k = k+1; yk = ykp1;
end

X(1:Nint,:) = reshape(yk,Nint,2);% es desfa el canvi de variable i s'actualitza la malla

fprintf('\nValor final de la distorsio: %2.7f\n',calculaDistorsioMalla(X,T)) 
figure(2),plotMesh(X,T), title('Malla optima') 
figure(3); plot(0:k-1,log10(relErr(1:k)),'-o')
xlabel('k'), ylabel('log_{10}(r^k)')
