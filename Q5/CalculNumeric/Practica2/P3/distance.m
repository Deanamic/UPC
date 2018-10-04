function dist = distance(v0, theta, t, tol)
[x, Y] = ode45(@f, [0, t], init_cond(v0, theta), odeset('AbsTol', tol, 'Events', @event));
dist = Y(end,1);