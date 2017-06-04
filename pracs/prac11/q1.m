% Prac 11 Q1
% Roy Portas

% Get the data range
x = [-1:0.05:8];

% Sample average (m)
m = mean(data);
% mu is also the mean
mu = m;


% Number of samples (N)
d = size(data);
N = d(1);

% Get the variance of data
sigma = var(data);

hold on;
% Plot normal
% plot(x, normpdf(x, mu, sigma));

% Chosen from inspecting the chart of the prac sheet
mu0 = 2;
sigma0 = 0.4;

% Plot data
scatter(data, zeros(size(data)), 'x');

posterior_mu = (sigma / (N * sigma0 + sigma) * mu0) + (N * sigma0 / (N * sigma0 + sigma) * m);
posterior_sigma = 1/(1/sigma0 + N/sigma);

% Posterior
plot(x, normpdf(x, posterior_mu, posterior_sigma), 'b');

% Prior
plot(x, normpdf(x, mu0, sigma0), 'r');

legend('Data', 'Posterior', 'Prior');
