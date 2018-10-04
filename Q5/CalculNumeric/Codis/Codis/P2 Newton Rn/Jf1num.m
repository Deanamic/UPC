function J = Jf1num(x,epsilon)
    J = zeros(3);
    J(:,1) = (f1(x+[1,0,0]*epsilon)-f1(x))/epsilon;
    J(:,2) = (f1(x+[0,1,0]*epsilon)-f1(x))/epsilon;
    J(:,3) = (f1(x+[0,0,1]*epsilon)-f1(x))/epsilon;
end