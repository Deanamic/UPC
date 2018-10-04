load corba
real = 21.228219155979843;
for m = 1:300
    val = integra(m, b);
    if (abs(val - real)/real < 1/20000)
        m
        integra(m, b)
        break;
    end
end



ant = integra(1, b);
for m = 2:1000
    val = integra(m, b);
    if (abs(val - ant)/val < 1/20000)
        m
        break;
    end
    ant = val;
end
