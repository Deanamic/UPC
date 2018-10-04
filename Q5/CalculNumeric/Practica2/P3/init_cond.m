function y0 = init_cond (v0, theta)
y0 = [0; 0; v0*cos(theta); v0*sin(theta)];