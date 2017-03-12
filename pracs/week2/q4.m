% Load the data
data = importdata('prac1_q4.dat');

% Get the columns we want
x = data(:, 1);
c2 = data(:, 2);
c3 = data(:, 3);

% Create a scatter plot

hold on;

scatter(x, c2, 'bo');
scatter(x, c3, 'rs');

% Draw labels
xlabel('Input');
ylabel('Output');

hold off;
