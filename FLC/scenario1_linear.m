function r = scenario1_linear(time)
r = zeros(length(time),1);

for  i = 1:length(time)
    t = time(i);
    if t<10
        r(i) = 150;
    elseif t>=10 && t<20
        r(i) = 100;
    else
        r(i) = 150;
    end
end

end