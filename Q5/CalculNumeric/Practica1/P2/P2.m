function alpha = P2(x0, a1, a2, a3, a4, beta, tol)
format long;

alpha = P2newton (x0, a1, a2, a3, a4, beta, tol);

x = zeros(4,1);
y = zeros(4,1);
x(2) = a2*cos(alpha);
x(3) = a1 + a4*cos(beta);
x(4) = a1;
y(2) = a2*sin(alpha);
y(3) = a4*sin(beta);
X = [x(1),x(4)];
Y = [y(1),y(4)];

plot(x,y, '--bh', 'LineWidth',8,X,Y,'--bh', 'LineWidth',8);

endfunction
