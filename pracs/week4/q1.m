
% Prac 3, Q1

% TODO: Look at mvnpdf

raw = readtable('pima_indians_diabetes.csv');

raw_data = raw(:, 1:8);

% The classfied classes, e.g. positive or negative
actual = table2array(raw(:, 9));
training_actual = actual(1:500);

% Convert the table into an array
data = table2array(raw_data);

% Split into training and testing
training = data(1:500, :);
testing = data(500:end, :);

% Divide training data into positive and negative samples

%% An array of data
training_positive = NaN(500, 8);
training_negative = NaN(500, 8);

%% Binary array of samples
positive = zeros(1, 500);
negative = zeros(1, 500);
for i = 1:500
    if strcmp(training_actual(i), 'pos')
        positive(i) = 1;
        training_positive(i, :) = training(i, :);
    else
        negative(i) = 1;
        training_negative(i, :) = training(i, :);
    end
end

% Find the covariance of the data
covariance = cov(training);

% Find the correlation
correlation = corr(training);

% Find the mean vector (mu)
mean_vector = zeros(1, 8);

for i = 1:8
    mean_vector(i) = mean(training(:, i));
end

% Equation 5.22
m1 = nanmean(training_positive);
m2 = nanmean(training_negative);

S1 = nancov(training_positive);
S2 = nancov(training_negative);

p1 = sum(positive)/length(positive);
p2 = sum(negative)/length(negative);

res = qd(testing, S1, m1, p1);

% Using mvnpdf
pdf = mvnpdf(training, mean_vector, covariance);

% Use built in matlab functions
quadratic = fitcdiscr(training, training_actual, 'DiscrimType', 'quadratic');
linear = fitcdiscr(training, training_actual);

predict(quadratic, testing);
predict(linear, testing);

function g = qd(x, S, m, p)
    % Equation 5.19
    % g = -1/2 * log(det(S)) - 1/2 * (x - m) * inv(S) * transpose(x - m) + log(p);

    % Equation 5.22
    g = -1/2 * transpose(x - m) * inv(S) * (x - m) + log(p);
end
