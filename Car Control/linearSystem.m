function points = linearSystem(time,initial_vector,velocity,controller)

position = initial_vector(1:2);
theta = initial_vector(3);
points = position';
x = position(1);
y = position(2);

for i = 2:length(time)
    [dh, dv] = compute_distance(position);
    
    if dh > 1
        dh = 1;
    elseif dh < 0
        dh = 0;
        fprintf('Out of bounds! \n');
    end
    
    if dv > 1
        dv = 1;
    elseif dv < 0
        dv = 0;
        fprintf('Out of bounds! \n');
    end
    
    dtheta = evalfis([dh dv theta],controller);
    x = x + velocity*cos(deg2rad(theta));
    y = y + velocity*sin(deg2rad(theta));
    theta = theta + dtheta;
    
    if theta > 180
        theta = theta - 360;
    elseif theta < - 180
        theta = 360 + theta;
    end
    
    position = [x; y];
    
    points = [points; x y];

    if x>10 && y <3.6
        break;
    end
    
end

end