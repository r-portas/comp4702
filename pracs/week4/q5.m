% Q5

x = [randn(30, 1); 5 + randn(30, 1)];

subplot(2, 2, 1);
hold on;
hist(x, 20);
title('Histogram with 20 bins');
xlabel('X values');
ylabel('Probability');
hold off;

% Demo the results
subplot(2, 2, 2);
yyaxis left;
hist(x, 20);
yyaxis right;

% Generate 100 random datapoints between that covers the range of data in x 
x_points = min(x):((max(x)-min(x))/99):max(x);

% Generate the histogram bin counts
[dist, edges] = histcounts(x, 20);
N = sum(dist);
x0 = edges(1);
h = edges(2) - edges(1);

data = zeros(1, 100);

for i = 1:100
    bin = ceil((x_points(i) - x0) / h);
    x_in_bin = dist(bin);
    
    data(i) = x_in_bin / (N * h);
end


% Create the kernel density estimators

% Default kernel width
[K1, k1x, bw1] = ksdensity(x, x_points);

% Half of the default kernel width
[K2, k2x, bw2] = ksdensity(x, x_points, 'width', bw1/2);

hold on;
plot(k1x, K1, 'r');
plot(k2x, K2, 'g');

title('K1 and K2 kernel densities');
legend('Data', 'K1', 'K2');
hold off;

% Calculate the Guassian mixed model
mixed = K1/2 + K2/2;

subplot(2, 2, 3);
hold on;
yyaxis left;
hist(x, 20);
yyaxis right;
plot (k1x, mixed, 'b');

title('Mixed Model');
legend('Data', 'Mixed model');
hold off;


subplot(2, 2, 4);
hold on;
hist(x, 20);
scatter(x_points, zeros(1, 100), 'r');

title('Test points');
legend('Data', 'Test points');
hold off;

% Do the calculations
KL(mixed, x, x_points);
KL(mixed, K1, x_points);
KL(mixed, K2, x_points);

%
% Calculate the KL Divergence
%
function result = KL(p, q, x)
    % Convert both to pdfs
    px = normpdf(x, mean(p), std(p));
    qx = normpdf(x, mean(q), std(q));
    result = sum(px * log(px/qx));
end
