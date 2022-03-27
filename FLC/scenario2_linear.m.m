function r = scenario2_linear(time)
r = zeros(length(time),1);

for  i = 1:length(time)
    t = time(i);
    if t<10
        r(i) = 15*t;
    elseif t>=10 && t<20
        r(i) = 150;
    else
        r(i) = -15*t+450;
    end
end

end