load heightWeight;

% Store the data into h
h = heightWeightData;

h_classes = h(:, 1);
h_x = h(:, 2);
h_y = h(:, 3);
h_data = h(:, 2:3);

% We have 2 classes
c = 2;

opts = statset('Display','final');

% scatter(h_x, h_y);
[idx, C] = kmeans(h_data, 2, 'Replicates', 5, 'Options', opts);

hold on;
plot(h_data(idx==1, 1), h_data(idx==1, 2), 'r.', 'MarkerSize', 12);
plot(h_data(idx==2, 1), h_data(idx==2, 2), 'b.', 'MarkerSize', 12);
plot(C(:,1), C(:, 2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);

legend('Cluster 1', 'Cluster 2', 'Centroids');
hold off;

