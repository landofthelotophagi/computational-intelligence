function [UA, PA, khat] = calculate_metrics(ErrorMatrix, N)

M = size(ErrorMatrix,1);
Xir = sum(ErrorMatrix, 2);
Xjc = sum(ErrorMatrix);
PA = zeros(M,1);
UA = zeros(M,1);
for i=1:M
    PA(i) = ErrorMatrix(i,i) / Xjc(i);
    UA(i) = ErrorMatrix(i,i) / Xir(i);
end
khat = (N* trace(ErrorMatrix) - sum(Xir .* Xjc)) / (N^2 - sum(Xir .* Xjc));


end