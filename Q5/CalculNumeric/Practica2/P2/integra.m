function [ res ] = integra(m,t)

load corba;
h = (t - a)/m;
res = 0;
for i = 1:m
    x1 = a+h*(i-1);
    x2 = a+h*i;
    res = res + h/6 * (norm(dgamma(x1)) + 4*norm(dgamma(((x1+x2)/2))) + norm(dgamma(x2)));
end

end

