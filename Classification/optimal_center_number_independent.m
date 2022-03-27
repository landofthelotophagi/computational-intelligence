function numofCenters = optimal_center_number_independent(data,clustersRadius)

numofCenters = zeros(length(clustersRadius),1);

for i=1:length(clustersRadius)
    centers = subclust(data, clustersRadius(i));
    [m,~] = size(centers);
    numofCenters(i) = m;
end

end