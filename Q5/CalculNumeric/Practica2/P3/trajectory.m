function fin_pos = trajectory(v0, theta, t, nsteps, show_plot)
[x,Y] = Euler(@f, 0, t, init_cond(v0, theta), nsteps);
fin_pos = Y([1,2], nsteps + 1);
if show_plot
    plot(Y(1,:),Y(2,:));
    grid on;
end