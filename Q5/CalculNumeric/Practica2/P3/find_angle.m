function theta = find_angle (x1, x2, d, t, v0, tol1, tol2)
x = [x1, x2];
y = [distance(v0, x1, t, tol1) - d, distance(v0, x2, t, tol1) - d];

i = 2;
while abs(y(i)) > tol2
  x(i+1) = x(i) - y(i)*(x(i) - x(i-1))/(y(i) - y(i-1));
  y(i+1) = distance(v0, x(i+1), t, tol1) - d;
  i = i+1;
end

theta = x(i);