function errorMatrix = fivefold_cross_validation(clustersRadius, nf, D_trn, ranks)

errorMatrix = zeros(length(nf), length(clustersRadius));

for i = 1:length(nf)
    
    train_data = D_trn(:,ranks(1:nf(i)));  

    for j = 1:length(clustersRadius)
        
        partition = cvpartition(size(D_trn,1),'kfold',5);
        
        model = genfis2(train_data, D_trn(:,end), clustersRadius(j));
        
        for u = 1:size(model.output(1).mf,2)
            model.output(1).mf(u).type = 'constant' ;
            model.output(1).mf(u).params= 2.5;
        end
        opt = anfisOptions('InitialFIS', model);
        opt.DisplayANFISInformation = 0;
        opt.DisplayErrorValues = 0;
        opt.DisplayStepSize = 0;
        opt.DisplayFinalResults = 0;

        error = 0;
        parfor k = 1:5
            Dtrn = [train_data(training(partition,k),:) D_trn(training(partition,k),end)];
            Dval = [train_data(test(partition,k),:) D_trn(test(partition,k),end)];
            [~,~,~,~,chkerror] = anfis(Dtrn,model,100,[0 0 0 0],Dval);
            error = error + min(chkerror) / 5 ;
        end
        errorMatrix(i,j) = error;
    end
end

end