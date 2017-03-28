
% Prac 3, Q1

% TODO: Look at mvnpdf

raw = readtable('pima_indians_diabetes.csv');

raw_data = raw(:, 1:8);

% The classfied classes, e.g. positive or negative
actual = table2array(raw(:, 9));
training_actual = actual(1:500);
testing_actual = actual(500:end);

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

positive = transpose(positive);
negative = transpose(negative);


pos_testing =  zeros(1, length(testing_actual));
neg_testing =  zeros(1, length(testing_actual));

% Parse the testing data
for i = 1:length(testing_actual)
    if strcmp(testing_actual(i), 'pos')
        pos_testing(i) = 1;
    else
        neg_testing(i) = 1;
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

% Using mvnpdf
pdf = mvnpdf(training, mean_vector, covariance);
pdf_positive = mvnpdf(training_positive, m1, S1);
pdf_negative = mvnpdf(training_negative, m2, S2);

% Remove the NaNs
pdf_positive(isnan(pdf_positive)) = 0;
pdf_negative(isnan(pdf_negative)) = 0;

% Posteriors
p_positive = pdf_positive ./ (pdf_positive + pdf_negative);

p_negative = pdf_negative ./ (pdf_positive + pdf_negative);

hold on;
bar(1:500, p_positive, 'r');
bar(1:500, p_negative, 'b');
legend('Positive', 'Negative');
xlim([1, 500]);
xlabel('Reading no.');
ylabel('P(c)');
title('Posteriors');
hold off;

% Calculate the error


% Use built in matlab functions
quadratic = fitcdiscr(training, training_actual, 'DiscrimType', 'quadratic');
linear = fitcdiscr(training, training_actual);

[c_training_quad, err_training_l] = predict(linear, training);
[c_testing_quad, err_testing_l] = predict(linear, testing);
predict(linear, testing)

const = linear.Coeffs(1,2).Const
linear = linear.Coeffs(1,2).Linear
