% Fuzzy Systems 2021 - Classification - Part1
% Evripidis Baltzis - 8196

%% Clear workspace before initializing
clear all;
close all;
warning('off','all');

%% Import and partition dataset 
% Load dataset
data = readtable('data.csv');
data = data(2:end, 2:end);
data = table2array(data);
data = data(randperm(size(data, 1)), :);
[m,n] = size(data);

% Partition training, validation and test set
N1 = floor(0.6*m);
N2 = floor(0.8*m);
D_trn = data(1:N1,:);
D_val = data((N1+1):N2, :);
D_chk = data((N2+1):end, :);

%% Training and Cross Validation
numberOfFeatures = [3; 6; 9; 12; 15];
clustersRadius = 0.1:0.04:0.6;

% Optimal feature selection
[ranks, weights] = relieff( data(:,1:end-1) ,data(:,end), 20);
% save ranks_part2.mat ranks

% load ranks.mat

% 5 fold cross validation
cv5fold = fivefold_cross_validation(clustersRadius, numberOfFeatures, D_trn, ranks);
save cv5fold.mat cv5fold;

% Find optimum values
% load cv_5fold.mat;
minimalError = min(min(cv5fold));
[row,col] = find(cv5fold == minimalError);
optimalFeaturesNumber = nf(row);
optimalClustersRadius = clustersRadius(col);
save optimalValues_part2.mat optimalFeaturesNumber optimalClustersRadius


%% Create and train model with optimal clusters radius and features number values
% load n_optimal.mat
Dtrn = D_trn(:,ranks(1:optimalFeaturesNumber));
Dval = D_val(:,ranks(1:optimalFeaturesNumber));
Dchk = D_chk(:,ranks(1:optimalFeaturesNumber));

Dtrn = [Dtrn D_trn(:,end)];
Dval = [Dval D_val(:,end)]; 
Dchk = [Dchk D_chk(:,end)]; 

model = genfis2(Dtrn(:,1:end-1), Dtrn(:,end),optimalClustersRadius);

for i = 1:size(model.output(1).mf,2)
    model.output(1).mf(i).type = 'constant' ;
    model.output(1).mf(i).params= 2.5;
end

opt = anfisOptions('InitialFIS', model);
opt.DisplayANFISInformation = 0;
opt.DisplayErrorValues = 0;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 0;

% Training
[trainingModel, trainingError_1, ~, chkFIS, chkError] = anfis(Dtrn,model,1000,[0 0 0 0],Dval);

%% Evaluate training results
predicted = evalfis(Dchk(:, 1:end-1), chkFIS);
predicted = round(predicted);

%% Plot required figures 

% Plot learning curves
figure;
plot(1:length(error),[error(:) val_error(:)]);
title('Learning Curve');
legend('Training','Cross Validation');
saveas(gcf,'part2_figures/LearningCurves.png');

% Plot estimation vs real values figure
figure
plot(predicted,'*'); hold on;
plot(Dchk(:,end),'*');
title('Estimated and Actual values');
legend('Estimations', 'Actual');
saveas(gcf,'part2_figures/Estimations_vs_Real.png');

% Plot random initial and final membership functions
figure;
subplot(3,1,1);
[xout,yout] = plotmf(model, 'input', 1);
plot(xout(:,1),yout(:,1)); hold on;
[xout,yout] = plotmf(fisopt, 'input', 1);
plot(xout(:,1),yout(:,1));
legend('Initial', 'Final');
title('Input 1 - MF 1');

subplot(3,1,2);
[xout,yout] = plotmf(model, 'input', 2);
plot(xout(:,2),yout(:,2)); hold on;
[xout,yout] = plotmf(fisopt, 'input', 2);
plot(xout(:,2),yout(:,2))
legend('Initial', 'Final')
title('Input 2 - MF 2')

subplot(3,1,3);
[xout,yout] = plotmf(model, 'input', 3);
plot(xout(:,3),yout(:,3)); hold on;
[xout,yout] = plotmf(fisopt, 'input', 3);
plot(xout(:,3),yout(:,3))
legend('Initial', 'Final')
title('Input 3 - MF 3')

suptitle('Membership functions')
saveas(gcf,'part2_figures/MembershipFunctions.png');

%% Error metrics
N = size(Dchk,1);

errorMatrix_part2 = calculate_error_matrix(Dchk, predicted);
OA_part2 = ( 1/N ) * trace(errorMatrix_part2);
[UA_part2, PA_part2, khat_part2] = calculate_metrics(errorMatrix_part2, N);

save metrics_part2.mat errorMatrix_part2 OA_part2 UA_part2 PA_part2 khat_part2