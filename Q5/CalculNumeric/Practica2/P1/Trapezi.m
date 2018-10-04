function res = Trapezi(f, l, r, xnum)
x = linspace(l, r, xnum+1);
res = 0;
h = (r-l)/xnum;
val = zeros(xnum+1, 1);
%Precalculem els n+1 punts que utilitzarem
for i = 1:xnum+1
    val(i) = f(x(i));
end

for i = 1:xnum
    res = res + (val(i) + val(i+1))*h/2;
end

end