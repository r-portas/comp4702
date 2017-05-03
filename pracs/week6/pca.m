%
% Principle Component Analysis
%
function result = pca(data)
    % Find the mean of the data
    m = mean(data);
    % Find the covariance on the normalized data
    S = cov(data - m);
    % Calculate the eigenvalues and eigenvectors of the covariance matrix
    [evec, eval] = eig(S);

    % Sort the eigenvalues
    [y, i] = sort(diag(eval), 'descend');
    % Sort the eigenvectors columns by the eigenvalue indexes
    evec = evec(:, i);
    
    % PCA only works if you subtract the mean
    result = evec' * (data - m)';
end
