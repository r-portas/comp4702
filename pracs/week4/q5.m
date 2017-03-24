% Q5

x = [randn(30, 1); 5 + randn(30, 1)];

% Demo the results
yyaxis left;
hist(x, 20);
yyaxis right;

% Create the kernel density estimators

% Default kernel width
[K1, k1x, bw1] = ksdensity(x);

% Half of the default kernel width
[K2, k2x, bw2] = ksdensity(x, 'width', bw1/2);

hold on;

plot(k1x, K1, 'r');
plot(k2x, K2, 'g');

% Generate 20 random datapoints between that covers the range of data in x 
x_points = min(x):((max(x)-min(x))/19):max(x);
scatter(x_points, zeros(1, 20));

% Calculate the Guassian mixed model
mixed = K1/2 + K2/2;
plot (k1x, mixed, 'b');

hold off;

% Do the calculations
KL(mixed, x, x_points)
KL(mixed, K1, x_points)
KL(mixed, K2, x_points)


%
% Calculate the KL Divergence
%
function result = KL(p, q, x)
    px = normpdf(x, mean(p), std(p)^2);
    qx = normpdf(x, mean(q), std(q)^2);
    result = sum(px * log(px/qx));
end
