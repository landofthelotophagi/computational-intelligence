function errorMatrix = fivefold_cross_validation(numberOfRules, numberOfFeatures, D_trn, ranks)
%% Search for the optimum values of nf and nr

errorMatrix = zeros(length(numberOfFeatures), length(numberOfRules));
opt = NaN(4,1); opt(4) = 0;

for i = 1:length(numberOfFeatures)
    trainingData = D_trn(:,ranks(1:numberOfFeatures(i)));   
    for j = 1:length(numberOfRules)
        
        partition = cvpartition(size(D_trn,1),'kfold',5);
        fis = genfis3(trainingData, D_trn(:,end), 'sugeno', numberOfRules(j), opt );
    
        error = 0;
        parfor k = 1:5
            Dtrn = [trainingData(training(partition,k),:) D_trn(training(partition,k),end)];
            Dval = [trainingData(test(partition,k),:) D_trn(test(partition,k),end)];
            [~,~,~,~,chkerror] = anfis(Dtrn,fis,100,[0 0 0 0],Dval);
            error = error + min(chkerror) / 5 ;
        end
        errorMatrix(i,j) = error;
    end
end

end