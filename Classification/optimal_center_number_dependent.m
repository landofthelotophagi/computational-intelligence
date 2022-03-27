function numOfCenters = optimal_center_number_dependent(data,clustersRadius)

numOfCenters = zeros(length(clustersRadius),1);

for i=1:length(clustersRadius)
    centers1 = subclust(data(data(:,end)==1, :), clustersRadius(i));
    centers2 = subclust(data(data(:,end)==2, :), clustersRadius(i));
    [m,~] = size(centers1);
    [n,~] = size(centers2);
    numOfCenters(i) = m + n;
end

end