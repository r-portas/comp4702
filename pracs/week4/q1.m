
% Prac 3, Q1

raw = readtable('pima_indians_diabetes.csv');

data = raw(:, 1:8);
actual = raw(:, 9);


% Question 1

% Create the quadratic classifier
quad = fitcdiscr(data, actual, 'DiscrimType', 'quadratic');

% Question 2

% Create the linear classifier
linear = fitcdiscr(data, actual);

