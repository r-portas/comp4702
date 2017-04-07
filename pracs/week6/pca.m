%
% Principle Component Analysis
%

function result = pca(data)
    m = mean(data);
    S = cov(data - m);
    [evec, eval] = eigs(S);

    % Sort the eigenvalues
    [y, i] = sort(diag(eval), 'descend');
    % Sort the eigenvectors columns by the eigenvalue indexes
    evec = evec(:, i);
    
    % PCA only works if you subtract the mean
    result = evec' * (data - m)';
end
