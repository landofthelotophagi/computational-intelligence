% Fuzzy Systems 2021 - FLC - DC Motor 7
% Evripidis Baltzis - 8196

%% Clear workspace before initializing
clear all;
close all;
warning('off','all');

%% Design linear controller according to desired specifications and simulate results 
% DC motor's transfer function
num_dc = 18.69;
den_dc = [1 12.064];
h_dc = tf(num_dc, den_dc);

% Controller's transfer function
num_controller = [1.25 23.2354];
den_controller = [1 0];
h_controller = tf(num_controller, den_controller);

% Transfer function of the open loop system
open_loop_system = series(h_dc, h_controller);

% Root locus plot for the open loop system
figure;
rlocus(open_loop_system)

% Transfer function of the closed loop system
K = 1;
open_loop_system = K * open_loop_system; % We have chosen K
sys_closed_loop = feedback(open_loop_system, 1, -1);

% Step response plot of the closed loop system
figure;
step(sys_closed_loop);

% Information about useful variables of the step response to varify that
% all desired specifications are met
info = stepinfo(sys_closed_loop)
% info.RiseTime
% info.Overshoot

%% Design fuzzy logic PI controller according to the above met criteria and simulate results
time = (0:0.01:3);
clear controller
controller = fuzzy_PI_controller();

% Input membership functions plots
figure;
plotmf(controller, 'input' , 1);
title('Membership Function of E');

figure;
plotmf(controller, 'input' , 2);
hl = title('Membership Function of $\dot{E}$');
set(hl, 'Interpreter', 'latex');

% Output membership function plot
figure;
plotmf(controller, 'output' , 1);
hl = title('Membership Function of $\dot{U}$');
set(hl, 'Interpreter', 'latex');

% Add rules to fuzzy controller
rules = rules_fuzzy_PI_controller();
controller = addrule(controller, rules);

% Steady state matrices
[A,B,C,D] = tf2ss(num_dc, den_dc);

u = 150*ones(length(time),1);
y = lsim(sys_closed_loop, u, time);

% Set initial values
ke = 1;
a = 0.05383;
kd = a*ke;
k1 = 23.2213;

initialvector = 0;
y_fuz = numerical_solution(time,initialvector,A,B,C,controller,ke,kd,k1,@sample_input);

% Plotting
figure;
plot(time, [y y_fuz]);
legend('Classic controller', 'Fuzzy controller');
title('Classic PI vs Fuzzy PI controller');
xlabel('Time');

% Set correction values
ke = 1.5;
a = 0.045;
kd = a*ke;
k1 = 26;

initialvector = 0; %[0;0]
y_fuz = numerical_solution(time,initialvector,A,B,C,controller,ke,kd,k1,@sample_input);

% Plot comparison figures
figure;
plot(time, [y y_fuz]);
legend('Classic controller', 'Fuzzy controller');
title('Classic PI vs Fuzzy PI controller');
xlabel('Time');

ruleview(controller);
 
%% 3D rule base surface generation
figure;
gensurf(controller)
title('3D output surface of the fuzzy PI controller');

%% Response to different scenario signals
time = (0:0.01:30);

%% Scenario 1
input_scenario1 = scenario1_linear(time);
linearOutput_scenario1 = lsim(sys_closed_loop, input_scenario1, time);
fuzzyOutput_scenario1 = math_solution(time,initialvector,A,B,C,controller,ke,kd,k1,@scenario1_discrete);

% Set correction values for scenario 1
ke = 30;
a = 0.02;
kd = a*ke;
k1 = 11;

correctedFuzzyOutput_scenario1 = math_solution(time,initialvector,A,B,C,controller,ke,kd,k1,@scenario1_linear);

figure;
plot(time, input_scenario1(:), 'b',time, linearOutput_scenario1(:), 'g');
legend('Reference signal', 'Classic controller');
title('Classic controller response');

figure;
plot(time, input_scenario1(:), 'b',time, fuzzyOutput_scenario1(:),'r');
legend('Reference signal', 'Fuzzy controller');
title('Fuzzy controller response');

figure;
plot(time, input_scenario1(:), 'b', time, correctedFuzzyOutput_scenario1(:),'c-.');
legend('Reference signal', 'Fuzzy Controller after correction');
title('corrected Fuzzy controller response');

figure;
plot(time, input_scenario1(:), 'b',time, linearOutput_scenario1(:), 'g', time, fuzzyOutput_scenario1(:),'r', time, correctedFuzzyOutput_scenario1(:),'c-.');
legend('Reference signal', 'Classic controller', 'Fuzzy controller', 'Fuzzy Controller after correction');
title('Classic vs Fuzzy vs corrected Fuzzy controller');


%% Scenario 2
input_scenario2 = scenario2_linear(time);
linearOutput_scenario2 = lsim(sys_closed_loop, input_scenario2, time);
fuzzyOutput_scenario2 = math_solution(time,initialvector,A,B,C,controller,ke,kd,k1,@scenario2_discrete);

% Set correction values for scenario 2
ke = 100;
a = 0.001;
kd = a*ke;
k1 = 1;

correctedFuzzyOutput_scenario2 = math_solution(time,initialvector,A,B,C,controller,ke,kd,k1,@scenario2_discrete);

figure;
plot(time, input_scenario2(:), 'b',time, linearOutput_scenario2(:), 'g');
legend('Reference signal', 'Classic controller');
title('Classic controller response');

figure;
plot(time, input_scenario2(:), 'b',time, fuzzyOutput_scenario2(:),'r');
legend('Reference signal', 'Fuzzy controller');
title('Fuzzy controller response');

figure;
plot(time, input_scenario2(:), 'b', time, correctedFuzzyOutput_scenario2(:),'c-.');
legend('Reference signal', 'Fuzzy Controller after correction');
title('corrected Fuzzy controller response');

figure;
plot(time, input_scenario2(:), 'b',time, linearOutput_scenario2(:), 'g', time, fuzzyOutput_scenario2(:),'r', time, correctedFuzzyOutput_scenario2(:),'c-.');
legend('Reference signal', 'Classic controller', 'Fuzzy controller','Fuzzy Controller after correction');
title('Classic vs Fuzzy vs corrected Fuzzy controller');