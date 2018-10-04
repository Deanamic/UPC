function error_plot(v0, theta, t, maxnsteps)

for i = 1 : log2(maxnsteps)
  [X(:,i)] = trajectory(v0, theta, t, 2^i, 0);
end

X

for i = 1 : log2(maxnsteps)-1
  E(i) = norm(X(:,i) - X(:,i+1));
  r(i) = E(i)/norm(X(:,i+1));
end

plot (1:log2(maxnsteps)-1, log2(r), 'b-o', 1:log2(maxnsteps)-1, log2(E), 'r-*');
grid on;