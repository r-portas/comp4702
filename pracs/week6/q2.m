load mnist_train;

data = train_X;
res = pca(data);

span1 = res(1, :);
span2 = res(2, :);


hold on;
scatter(span1(1:5923), span2(1:5923), 'b');
scatter(span1(5924:12666), span2(5924:12666), 'r');
scatter(span1(12667:18622), span2(12667:18622), 'y');
scatter(span1(18623:24755), span2(18623:24755), 'r+');
scatter(span1(18623:24755), span2(18623:24755), 'k');
scatter(span1(24756:30597), span2(24756:30597), 'g');
scatter(span1(30598:36018), span2(30598:36018), 'm');
scatter(span1(36018:41936), span2(36018:41936), 'cx');
scatter(span1(41937:48201), span2(41937:48201), 'bs');
scatter(span1(48202:54052), span2(48202:54052), 'gs');
scatter(span1(54053:60000), span2(54053:60000), 'ms');
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
% > 5.11

% Second principle component variance
y(2)
% > 3.74
