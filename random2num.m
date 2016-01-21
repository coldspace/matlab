function x = random2num(a,b)
    test = round(rand(1,1) * 10000);
    test = mod(test,2);
    if test
        x = a;
    else
        x = b;
end