
% Prac 3, Q1

% TODO: Look at mvnpdf

raw = readtable('pima_indians_diabetes.csv');

raw_data = raw(:, 1:8);

% The classfied classes, e.g. positive or negative
actual = raw(:, 9);

% Convert the table into an array
data = table2array(raw_data);

% Split into training and testing
training = data(1:500, :);
testing = data(500:end, :);

% Create the quadratic classifier

% Find the covariance of the data
covariance = cov(training);

% Find the mean vector (mu)
mean_vector = zeros(1, 8);

for i = 1:8
    mean_vector(i) = mean(training(:, i));
end

mean_vector = transpose(mean_vector);


% Use the quadratic discriminant function (Eq. 5.9)
p1 = 1 / ((2*pi)^(8/2) * sqrt(det(covariance)));
p2 = exp(-1/2 * transpose(training - mean_vector) * inv(covariance) * (training - mean_vector));

p = p1 * p2;

% Using mvnpdf
pdf = mvnpdf(training, mean_vector, covariance);
