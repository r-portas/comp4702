load swiss_roll_data;

data = X_data;
res = pca(data);

span1 = res(1, :);
span2 = res(2, :);


hold on;
scatter(span1, span2, 'b');
hold off;

% What percentage of the variance is account by the first two components
m = mean(data);
S = cov(data - m);
[evec, eval] = eigs(S);

% Sort the eigenvalues
[y, i] = sort(diag(eval), 'descend');
% Sort the eigenvectors columns by the eigenvalue indexes

% First principle component variance
y(1)
% Second principle component variance
y(2)
