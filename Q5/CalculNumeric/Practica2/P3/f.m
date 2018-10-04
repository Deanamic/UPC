function z = f(x,y)
R = 0.00132; g = -9.8;
z = [y(3); y(4); -R*norm(y(3),y(4))*y(3); -R*norm(y(3),y(4))*y(4) + g];