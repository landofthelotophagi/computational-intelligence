function r = scenario2_discrete(t)
if t<10
    r = 15*t;
elseif t>=10 && t<20
    r = 150;
else
    r = -15*t+450;
end

end