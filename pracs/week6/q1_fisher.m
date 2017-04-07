load fisheriris;

data = meas(:, 1:2);
res = pca(data);

m = mean(data);
[evec, eval] = eig(cov(data - m));
[y, i] = sort(diag(eval), 'descend');
% Sort the eigenvectors columns by the eigenvalue indexes
evec = evec(:, i);
first_evec = evec(:, 1);
second_evec = evec(:, 2);

hold on;
scatter(data(:, 1) - m(1), data(:, 2) - m(2), 'k');

% Plot eigenvectors
plot([-2*first_evec(1) 0 2*first_evec(1)], [-2*first_evec(2) 0 2*first_evec(2)], 'b');
plot([-2*second_evec(1) 0 2*second_evec(1)], [-2*second_evec(2) 0 2*second_evec(2)], 'r');

legend('Data', 'First Eigenvector', 'Second Eigenvector');
hold off;
