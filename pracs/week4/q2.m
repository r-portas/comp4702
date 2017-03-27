%
% Q2
% Linear Discriminant Analysis
%

% General Steps
% 1. Compute d-dimensional means vectors for each class
% 2. Compute 'Scatter' matrices in between class and within class
% 3. Compute eigenvectors and corresponding eigenvalues for the scatter matrices
% 4. Sort the eigenvectors by decreasing eigenvalues and choose the largest to form a matrix (W)
% 5. Use the new matrix to transform the samples onto the new subspace

%% Step 0: Load the data
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

% Divide training data into positive and negative classes

% An array of data
training_positive = NaN(500, 8);
training_negative = NaN(500, 8);

% Binary array of samples
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

%% Step 1: Calculate the mean vectors

% Class 1 mean vector
pos_mean_vector = nanmean(training_positive);

% Class 2 mean vector
neg_mean_vector = nanmean(training_negative);

%% Step 2: Compute scatter matrices
% These will be 8x8 matrices for each class

positive_scatter_matrix = zeros(8, 8);
for i = 1:length(training_positive)
    mv = transpose(pos_mean_vector);
    row = transpose(training_positive(i, :));

    if not(any(isnan(row)))
        positive_scatter_matrix = positive_scatter_matrix + (row - mv) * (transpose(row - mv));
    end
end

within_class_scatter_matrix = positive_scatter_matrix;

negative_scatter_matrix = zeros(8, 8);
for i = 1:length(training_negative)
    mv = transpose(neg_mean_vector);
    row = transpose(training_negative(i, :));

    if not(any(isnan(row)))
        negative_scatter_matrix = negative_scatter_matrix + (row - mv) * (transpose(row - mv));
    end
end

within_class_scatter_matrix = within_class_scatter_matrix + negative_scatter_matrix;

% Calculate the between class scatter matrix
between_class_scatter_matrix = zeros(8, 8);

overall_mean = transpose(mean(training));

% Do it for positive first
mv = transpose(pos_mean_vector);

n = length(find(all(~isnan(training_positive), 2)));

temp = n * (mv - overall_mean) * transpose(mv - overall_mean);

between_class_scatter_matrix = between_class_scatter_matrix + temp;

% Do it for negative
mv = transpose(neg_mean_vector);

n = length(find(all(~isnan(training_negative), 2)));

temp = n * (mv - overall_mean) * transpose(mv - overall_mean);

between_class_scatter_matrix = between_class_scatter_matrix + temp;

%% Step 3: Calculate the eigenvectors and eigenvalues

e = eig(inv(within_class_scatter_matrix) * between_class_scatter_matrix);
[V, D] = eig(inv(within_class_scatter_matrix) * between_class_scatter_matrix);

%% Step 4: Sort the eigenvectors and eigenvalues by decreasing order
[a, b] = sort(e, 'descend');

best_eig_value = a(1);
best_eig_vector = V(b(1), :);

second_best_eig_value = a(2);
second_best_eig_vector = V(b(2), :);

W = zeros(8, 2);

W(:, 1) = transpose(best_eig_vector);
W(:, 2) = transpose(second_best_eig_vector);

% The W matrix

real(W)

% Multiply the training data with W to classify
training_lda = training * W;
