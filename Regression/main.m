% Fuzzy Systems 2021 - Regression
% Evripidis Baltzis - 8196

%% Clear workspace before initializing
clear all;
close all;
warning('off','all');

%% Import and partition dataset 
Loading
data = load('airfoil_self_noise.dat');
data = data(randperm(size(data, 1)), :);
[m,n] = size(data);

% Partition training, validation and test set
trainLimit = floor(0.6*m);
validationLimit = floor(0.8*m);
D_trn = data(1:trainLimit,:);
D_val = data((trainLimit+1):validationLimit, :);
D_chk = data((validationLimit+1):end, :);

%% Create and train required models
% Models
model_1 = genfis1(D_trn, 2, 'gbellmf', 'constant');
model_2 = genfis1(D_trn, 3, 'gbellmf', 'constant');
model_3 = genfis1(D_trn, 2, 'gbellmf', 'linear');
model_4 = genfis1(D_trn, 3, 'gbellmf', 'linear');

opt = anfisOptions('InitialFIS', model_1, 'EpochNumber', 100, 'ValidationData', D_val);
[trainingModel_1, trainingError_1, ~ , chkFIS_1, chkError_1] = anfis(D_trn, opt);

opt = anfisOptions('InitialFIS', model_2, 'EpochNumber', 100, 'ValidationData', D_val);
[trainingModel_2, trainingError_2, ~, chkFIS_2, chkError_2] = anfis(D_trn, opt);

opt = anfisOptions('InitialFIS', model_3, 'EpochNumber', 100, 'ValidationData', D_val);
[trainingModel_3, trainingError_3, ~, chkFIS_3, chkError_3] = anfis(D_trn, opt);

opt = anfisOptions('InitialFIS', model_4, 'EpochNumber', 100, 'ValidationData', D_val);
[trainingModel_4, trainingError_4, ~, chkFIS_4, chkError_4] = anfis(D_trn, opt);

%% Plot membership functions
%% Model 1
figure;
subplot(3,2,1);
[x, mf] = plotmf(trainingModel_1, 'input', 1);
plot(x,mf);
xlabel('Frequency, in hertzs');

subplot(3,2,2);
[x,mf] = plotmf(trainingModel_1, 'input', 2);
plot(x,mf);
xlabel('Angle of attack, in degrees');

subplot(3,2,3);
[x,mf] = plotmf(trainingModel_1, 'input', 3);
plot(x,mf);
xlabel('Chord length, in meters');

subplot(3,2,4);
[x, mf] = plotmf(trainingModel_1, 'input', 4);
plot(x,mf);
xlabel('Free-stream velocity, in meters per second');

subplot(3,2,5);
[x, mf] = plotmf(trainingModel_1, 'input', 5);
plot(x,mf);
xlabel('Suction side displacement thickness, in meters');

suptitle('TSK model 1: Trained membership functions')
saveas(gcf,'part1_figures/TSK_1_membership_functions.png');

%% Model 2
figure;
subplot(3,2,1);
[x, mf] = plotmf(trainingModel_2, 'input', 1);
plot(x,mf);
xlabel('Frequency, in hertzs');

subplot(3,2,2);
[x,mf] = plotmf(trainingModel_2, 'input', 2);
plot(x,mf);
xlabel('Angle of attack, in degrees');

subplot(3,2,3);
[x,mf] = plotmf(trainingModel_2, 'input', 3);
plot(x,mf);
xlabel('Chord length, in meters');

subplot(3,2,4);
[x, mf] = plotmf(trainingModel_2, 'input', 4);
plot(x,mf);
xlabel('Free-stream velocity, in meters per second');

subplot(3,2,5);
[x, mf] = plotmf(trainingModel_2, 'input', 5);
plot(x,mf);
xlabel('Suction side displacement thickness, in meters');

suptitle('TSK model 2: Trained membership functions')
saveas(gcf,'part1_figures/TSK_2_membership_functions.png');

%% Model 3
figure;
subplot(3,2,1);
[x, mf] = plotmf(trainingModel_3, 'input', 1);
plot(x,mf);
xlabel('Frequency, in hertzs');

subplot(3,2,2);
[x,mf] = plotmf(trainingModel_3, 'input', 2);
plot(x,mf);
xlabel('Angle of attack, in degrees');

subplot(3,2,3);
[x,mf] = plotmf(trainingModel_3, 'input', 3);
plot(x,mf);
xlabel('Chord length, in meters');

subplot(3,2,4);
[x, mf] = plotmf(trainingModel_3, 'input', 4);
plot(x,mf);
xlabel('Free-stream velocity, in meters per second');

subplot(3,2,5);
[x, mf] = plotmf(trainingModel_3, 'input', 5);
plot(x,mf);
xlabel('Suction side displacement thickness, in meters');

suptitle('TSK model 3: Trained membership functions')
saveas(gcf,'part1_figures/TSK_3_membership_function1.png');

%% Model 4
figure;
subplot(3,2,1);
[x, mf] = plotmf(trainingModel_4, 'input', 1);
plot(x,mf);
xlabel('Frequency, in hertzs');

subplot(3,2,2);
[x,mf] = plotmf(trainingModel_4, 'input', 2);
plot(x,mf);
xlabel('Angle of attack, in degrees');

subplot(3,2,3);
[x,mf] = plotmf(trainingModel_4, 'input', 3);
plot(x,mf);
xlabel('Chord length, in meters');

subplot(3,2,4);
[x, mf] = plotmf(trainingModel_4, 'input', 4);
plot(x,mf);
xlabel('Free-stream velocity, in meters per second');

subplot(3,2,5);
[x, mf] = plotmf(trainingModel_4, 'input', 5);
plot(x,mf);
xlabel('Suction side displacement thickness, in meters');

suptitle('TSK model 4: Trained membership functions')
saveas(gcf,'part1_figures/TSK_4_membership_functions.png');

%Plot Learning Curves
figure;
subplot(2,2,1);
plot(1:length(trainingError_1),[trainingError_1 chkError_1]);
legend('Training Error', 'Cross Validation Error');
title('TSK model 1');

subplot(2,2,2);
plot(1:length(trainingError_2),[trainingError_2 chkError_2]);
legend('Training Error', 'Cross Validation Error');
title('TSK model 2');

subplot(2,2,3);
plot(1:length(trainingError_3),[trainingError_3 chkError_3]);
legend('Training Error', 'Cross Validation Error');
title('TSK model 3');

subplot(2,2,4);
plot(1:length(trainingError_4),[trainingError_4 chkError_4]);
legend('Training Error', 'Cross Validation Error');
title('TSK model 4');

suptitle('Learning Curves')
saveas(gcf,'part1_figures/TSK_LearningCurves.png');

%% Calculate metrics
out_1 = evalfis(D_chk(:,1:5), trainingModel_1);
out_2 = evalfis(D_chk(:,1:5), trainingModel_2);
out_3 = evalfis(D_chk(:,1:5), trainingModel_3);
out_4 = evalfis(D_chk(:,1:5), trainingModel_4);

% Error Matrix
error_part2 = out_1(:) - D_chk(:,6);
error_2 = out_2(:) - D_chk(:,6);
error_3 = out_3(:) - D_chk(:,6);
error_4 = out_4(:) - D_chk(:,6);
errorMatrix_2 = [error_part2 error_2 error_3 error_4];

% MSE & RMSE
mse_1 = (1 / length(error_part2)) * sum(error_part2.^2);
mse_2 = (1 / length(error_2)) * sum(error_2.^2);
mse_3 = (1 / length(error_3)) * sum(error_3.^2);
mse_4 = (1 / length(error_4)) * sum(error_4.^2);
mseMatrix = [mse_1; mse_2; mse_3; mse_4];
rmseMatrix = sqrt(mseMatrix);

% R^2 coefficient
yhat_part2 = mean(D_chk(:,5));
Rsq_1 = 1 - (sum(error_part2.^2)/sum((D_chk(:,6) - yhat_part2).^2));
Rsq_2 = 1 - (sum(error_2.^2)/sum((D_chk(:,6) - yhat_part2).^2));
Rsq_3 = 1 - (sum(error_3.^2)/sum((D_chk(:,6) - yhat_part2).^2));
Rsq_4 = 1 - (sum(error_4.^2)/sum((D_chk(:,6) - yhat_part2).^2));
Rsq_Matrix = [Rsq_1; Rsq_2; Rsq_3; Rsq_4];

% NMSE and NDEI
nmse_1 = (sum(error_part2.^2)/sum((D_chk(:,6) - yhat_part2).^2)); 
nmse_2 = (sum(error_2.^2)/sum((D_chk(:,6) - yhat_part2).^2)); 
nmse_3 = (sum(error_3.^2)/sum((D_chk(:,6) - yhat_part2).^2)); 
nmse_4 = (sum(error_4.^2)/sum((D_chk(:,6) - yhat_part2).^2)); 
nmseMatrix = [nmse_1; nmse_2; nmse_3; nmse_4];
ndeiMatrix = sqrt(nmseMatrix);

%% Error Plots
figure;
subplot(2,2,1);
plot(error_part2);
title('TSK model 1')

subplot(2,2,2);
plot(error_2);
title('TSK model 2')

subplot(2,2,3);
plot(error_3);
title('TSK model 3')

subplot(2,2,4);
plot(error_4);
title('TSK model 4')
 
suptitle('Prediction Errors of models');
saveas(gcf,'part1_figures/ErrorPlot.png');

save metrics_part1.mat errorMatrix mseMatrix rmseMatrix RsqMatrix nmseMatrix ndeiMatrix;


%% Part 2 
%% %% Import and partition dataset 
data = readtable('train.csv');
data = table2array(data);
data = data(randperm(size(data, 1)), :);
[m,n] = size(data);

% Partition training, validation and test set
trainLimit = floor(0.6*m);
validationLimit = floor(0.8*m);
D_trn = data(1:trainLimit,:);
D_val = data((trainLimit+1):validationLimit, :);
D_chk = data((validationLimit+1):end, :);

%% Training and Cross validation
numberOfFeatures = [3;6;9;12];
numberOfRules = [3;6;9;12;15];

% Optimal feature selection
[ranks, weights] = relieff( data(:,1:end-1) ,data(:,end), 200);
% save ranks.mat ranks

% load ranks

% 5 fold cross validation
cv5fold = fivefold_cross_validation(numberOfRules, numberOfFeatures, D_trn, ranks);
save cv5fold.mat cv5fold;

% Find optimum values
% load cv5fold;
minimalError = min(min(cv5fold));
[row,col] = find(cv5fold == minimalError);
optimalFeaturesNumber = numberOfFeatures(row);
optimalRulesNumber = numberOfRules(col);

%% Create and train model with optimal clusters radius and features number values
Dtrn = D_trn(:,ranks(1:optimalFeaturesNumber));
Dval = D_val(:,ranks(1:optimalFeaturesNumber));
Dchk = D_chk(:,ranks(1:optimalFeaturesNumber));

Dtrn = [Dtrn D_trn(:,end)];
Dval = [Dval D_val(:,end)]; 
Dchk = [Dchk D_chk(:,end)]; 

% initialize fuzzy system
% Generate a Sugeno-type FIS with 3 clusters.
opt = NaN(4,1); opt(4) = 0;
% Initialize fis
model = genfis3(Dtrn(:, 1:(end-1)),Dtrn(:,end),'sugeno',optimalRulesNumber,opt);
% Train FIS with Dtrn, Dval
opt = anfisOptions('InitialFIS', model, 'EpochNumber',  100, 'ValidationData', Dval);
opt.DisplayANFISInformation = 0;
opt.DisplayErrorValues = 0;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 0;
[trainingModel,trainingError,~,chkFIS,chkError]=anfis(Dtrn, opt);

%% Evaluate training results
output = evalfis(Dchk(:,1:end-1), chkFIS);
predicted = Dchk(:,end) - output(:);

%% Plottings
% Plot learning curve
figure;
plot(1:length(trainingError),[trainingError(:) chkError(:)]);
title('Learning Curve');
legend('Training','Cross Validation');
saveas(gcf,'part2_figures/LearningCurves.png');

% Plot estimation vs real values figure
figure
plot(output,'*'); hold on;
plot(Dchk(:,end),'*');
title('Estimated and Actual values');
legend('Estimations', 'Actual');
saveas(gcf,'part2_figures/Estimations_vs_Real.png');

% Plot random initial and final membership functions
figure;
subplot(3,1,1);
[xout,yout] = plotmf(model, 'input', 1);
plot(xout(:,1),yout(:,1)); hold on;
[xout,yout] = plotmf(chkFIS, 'input', 1);
plot(xout(:,1),yout(:,1));
legend('Initial', 'Final');
title('Input 1 - MF 1');

subplot(3,1,2);
[xout,yout] = plotmf(model, 'input', 2);
plot(xout(:,2),yout(:,2)); hold on;
[xout,yout] = plotmf(chkFIS, 'input', 2);
plot(xout(:,2),yout(:,2))
legend('Initial', 'Final')
title('Input 2 - MF 2')

subplot(3,1,3);
[xout,yout] = plotmf(model, 'input', 3);
plot(xout(:,3),yout(:,3)); hold on;
[xout,yout] = plotmf(chkFIS, 'input', 3);
plot(xout(:,3),yout(:,3))
legend('Initial', 'Final')
title('Input 3 - MF 3')

suptitle('Membership functions')
saveas(gcf,'part2_figures/MembershipFunctions.png');

%% Calculate Metrics
error_part2 = predicted;
mse_part2 = (1 / length(error_part2)) * sum(error_part2.^2);
rmse_part2 = sqrt(mse_part2);
yhat_part2 = mean(D_chk(:,end));
Rsq_part2 = 1 - (sum(error_part2.^2)/sum((D_chk(:,end) - yhat_part2).^2));
nmse_part2 = (sum(error_part2.^2)/sum((D_chk(:,end) - yhat_part2).^2)); 
ndei_part2 = sqrt(nmse_part2);

save metric_part2.mat error_part2 mse_part2 rmse_part2 Rsq_part2 nmse_part2 ndei_part2;