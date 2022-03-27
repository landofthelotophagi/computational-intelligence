% Fuzzy Systems 2021 - Classification - Part1
% Evripidis Baltzis - 8196

%% Clear workspace before initializing
clear all;
close all;
warning('off','all');

%% Import and partition dataset 
data = load('haberman.data');
[D_trn, D_val, D_chk] = splitData(data);
% load data;
% load D_trn;
% load D_val;
% load D_chk;

%% Training
% Models
numberOfFeatures = [12;60];
clustersRadius = 0.1:0.001:0.5;

% Finding optimal clusters' radius with class independent subtractive
% clustering method
optimalCentersIndependent = optimal_centers_independent(D_trn(:,1:end-1),clustersRadius);
optimalRadsIndependent = optimal_radius(optimalCentersIndependent, numberOfFeatures, clustersRadius);

% Finding optimal clusters' radius with class dependent subtractive
% clustering method
optimalCentersDependent = optimal_centers_independent(D_trn,clustersRadius);
optimalRadsDependent = optimal_radius(optimalCentersDependent, numberOfFeatures, clustersRadius);

% Merging optimal radius matrixes
optimalRads = [optimalRadsIndependent optimalRadsDependent];

save optimalRads.mat optimalRads
save D_trn.mat D_trn
save D_val.mat D_val
save D_chk.mat D_chk
% load optimalRads.mat
 
% Create and train models
[model1, trainingError_1, chkFIS_1, chkError_1] = create_model(D_trn, D_val, optimalRads(1));
[model2, trainingError_2, chkFIS_2, chkError_2] = create_model(D_trn, D_val, optimalRads(2));
[model3, trainingError_3, chkFIS_3, chkError_3] = create_model(D_trn, D_val, optimalRads(3));
[model4, trainingError_4, chkFIS_4, chkError_4] = create_model(D_trn, D_val, optimalRads(4));

%% Evaluate training results
predicted_1 = evalfis(D_chk(:, 1:end-1), chkFIS_1);
round(predicted_1);

predicted_2 = evalfis(D_chk(:, 1:end-1), chkFIS_2);
predicted_2 = round(predicted_2);

predicted_3 = evalfis(D_chk(:, 1:end-1), chkFIS_3);
predicted_3 = round(predicted_3);

predicted_4 = evalfis(D_chk(:, 1:end-1), chkFIS_4);
predicted_4 = round(predicted_4);

%% Plot required figures
% Plot models' learning curves
figure;
plot(1:length(train_error_1),[train_error_1 cv_error_1]);
legend('Training Error', 'Cross Validation Error');
title('TSK model 1 - Learning curve');
saveas(gcf,'part1_figures/TSK_1_LearningCurves.png');

figure;
plot(1:length(train_error_2),[train_error_2 cv_error_2]);
legend('Training Error', 'Cross Validation Error');
title('TSK model 2 - Learning curve');
saveas(gcf,'part1_figures/TSK_2_LearningCurves.png');

figure;
plot(1:length(train_error_3),[train_error_3 cv_error_3]);
legend('Training Error', 'Cross Validation Error');
title('TSK model 3 - Learning curve');
saveas(gcf,'part1_figures/TSK_3_LearningCurves.png');

figure;
plot(1:length(train_error_4),[train_error_4 cv_error_4]);
legend('Training Error', 'Cross Validation Error');
title('TSK model 4 - Learning curve');
saveas(gcf,'part1_figures/TSK_4_LearningCurves.png');

% Plot models' membership functions
models = [model_1;model_2;model_3;model_4];
for count=1:4
    figure;
    N = size(models(count).input,2);
    for i = 1:N
        subplot(N,2,i);
        [x, mf] = plotmf(models(count), 'input',i);
        plot(x,mf);
    end

    suptitle(['TSK model ' int2str(count) ': Trained membership functions']);
    saveas(gcf,['part1_figures/TSK_' int2str(count) '_membership_functions.png']);
end
 
%% Calculate Metrics
N = size(D_chk,1);

% Error Matrix
errorMatrix_1 = calculate_error_matrix(D_chk, predicted_1);
errorMatrix_2 = calculate_error_matrix(D_chk, predicted_2);
errorMatrix_3 = calculate_error_matrix(D_chk, predicted_3);
errorMatrix_4 = calculate_error_matrix(D_chk, predicted_4);

errorMatrix = [errorMatrix_1;errorMatrix_2;errorMatrix_3;errorMatrix_4];
 
% % OA
OA_1 = ( 1/N ) * trace(errorMatrix_1);
OA_2 = ( 1/N ) * trace(errorMatrix_2);
OA_3 = ( 1/N ) * trace(errorMatrix_3);
OA_4 = ( 1/N ) * trace(errorMatrix_4);

OA = [OA_1; OA_2; OA_3; OA_4];

% UA, PA and khat
[UA_1, PA_1, k_1] = calculate_metrics(errorMatrix_1, N);
[UA_2, PA_2, k_2] = calculate_metrics(errorMatrix_2, N);
[UA_3, PA_3, k_3] = calculate_metrics(errorMatrix_3, N);
[UA_4, PA_4, k_4] = calculate_metrics(errorMatrix_4, N);
 
UA = [UA_1;UA_2;UA_3;UA_4];
PA = [PA_1;PA_2;PA_3;PA_4];
khat = [k_1; k_2; k_3; k_4];

save errorMatrix ErrorMatrix 
save OA.mat OA
save UA.mat UA
save PA.mat PA
save khat.mat khat