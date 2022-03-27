function radiusMatrix = optimal_radius(numOfCenters, numOfRules, clustersRadius)

radiusMatrix = [];

for i = 1:length(numOfRules)
    index = [];
    k = 0;
    
    while(isempty(index) && (numOfRules(i)-k)>0)
        index = find(numOfCenters == (numOfRules(i)-k));
        k = k + 1;
    end
    
    radiusMatrix = [radiusMatrix clustersRadius(index(1))];
    
end

end