function res = Simpson(f, l, r, xnum)
x = linspace(l, r, xnum+1);
h = (r-l)/xnum;
val = zeros(xnum+1, 1);
mid = zeros(xnum, 1);

for i = 1:xnum+1
   val(i) = f(x(i));
end

for i = 1:xnum
    mid(i) = f((x(i)+x(i+1))/2);
end
res = 0;

for i = 1:xnum
    res = res + (val(i) + 4*mid(i) + val(i+1)) * h/6;
end

end
