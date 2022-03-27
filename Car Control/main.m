% Fuzzy Systems 2021 - Car Control - Set 1
% Evripidis Baltzis - 8196
% Meeting specifications and designing of fuzzy PI controller

%% Clear workspace before initializing
clear all;
close all;
warning('off','all');

%% Part 1 - Design fuzzy logic PI controller

% Initialize controller and set required parameters
clear controller;
initialController = fuzzy_PI_controller();
correctedController = corrected_fuzzy_PI_controller();

%% Plot membership functions

% Initial controller
% Input membership functions plots
figure;
plotmf(initialController, 'input' , 1);
title('Membership Functions of d_{h} ');

saveas(gcf,'figures/dh.png');

figure;
plotmf(initialController, 'input' , 2);
title('Membership Functions of d_{v}');

saveas(gcf,'figures/dv.png');

figure;
plotmf(initialController, 'input' , 3);
title('Membership Functions of {\theta}');

saveas(gcf,'figures/theta.png');

% Output membership function plot
figure;
plotmf(initialController, 'output' , 1);
title('Membership Functions of d{\theta}');

saveas(gcf,'figures/dtheta.png');

% Corrected controller
% Input membership functions plots
figure;
plotmf(correctedController, 'input' , 1);
title('Membership Functions of d_{h} ');

saveas(gcf,'figures/dh_corrected.png');

figure;
plotmf(correctedController, 'input' , 2);
title('Membership Functions of d_{v}');

saveas(gcf,'figures/dv_corrected.png');

figure;
plotmf(correctedController, 'input' , 3);
title('Membership Functions of {\theta}');

saveas(gcf,'figures/theta_corrected.png');

% Output membership function plot
figure;
plotmf(correctedController, 'output' , 1);
title('Membership Functions of d{\theta}');

saveas(gcf,'figures/dtheta_corrected.png');

% Add rules to fuzzy controller
rules = rules_fuzzy_PI_controller();
initialController = addrule(initialController, rules);
correctedController = addrule(correctedController, rules);

% ruleview(controller);
%% Part 2 - Simulation
velocity = 0.05; % We want velocity for step dt
time = 0:0.1:300;
initial_position = [4.1; 0.3];
initial_theta = [-90;-45;0];

for i=1:length(initial_theta)
    initial_vector = [initial_position; initial_theta(i)];

    % Simulation
    points = linearSystem(time,initial_vector,velocity,initialController);
    x = points(:,1);
    y = points(:,2);

    points = linearSystem(time,initial_vector,velocity,correctedController);
    x1 = points(:,1);
    y1 = points(:,2);
    error1 = sqrt((x1(end)-10)^2+(y1(end)-3.2)^2);

    %% plotting results
    figure;
    
    % initial and final point
    h1 = scatter(10,3.2,60,[0.6350 0.0780 0.1840],'x','LineWidth',3); 
    hold on;
    h2 = scatter(4.1,0.3,60,[0.9290, 0.6940, 0.1250],'x','LineWidth',3); 
    hold on;
    
    % route edges
    h3 = line([5 5],[0 1],'Color', 'r');
    h4 = line([5 6],[1 1],'Color', 'r');
    h5 = line([6 6],[1 2],'Color', 'r');
    h6 = line([6 7],[2 2],'Color', 'r');
    h7 = line([7 7],[2 3],'Color', 'r');
    h8 = line([7 11],[3 3],'Color', 'r');
  
    % car routes
    h9 = scatter(x,y,10, 'filled'); hold on;
    h10 = scatter( x1, y1, 10, 'filled'); hold on;
    
    legend([h1 h2],'Final Point','Initial Point');
    legend([h9 h10], 'Initial Controller','Corrected Controller');
    
    xlim([0,11]);
    ylim([0 4]);
    
    title('Route for {\theta}_{0} = -90');
end