function errorMatrix = calculate_error_matrix(D_chk, predout)

errorMatrix = zeros(max(D_chk(:,end)));
[m,~] = size(errorMatrix);

for i =1:m
    for j =1:m
        errorMatrix(i,j) = sum((predout == i) .* (D_chk(:,end) == j));
    end
end

end