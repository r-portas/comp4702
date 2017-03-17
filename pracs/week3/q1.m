% Plot f(x) = 2*sin(1.5x)

x = linspace(0, 5);
y = 2 * sin(1.5 * x);


num = 20;

% Calculate the random readings
err = randn(num, 1);
upper = 5;
lower = 0;

% Testing data
test_x = (upper - lower) .* rand(num, 1) + lower;
test_y = 2 * sin(1.5 * test_x);
test_y = test_y + err;

% Validation data
validation_x = (upper - lower) .* rand(num, 1) + lower;
validation_y = 2 * sin(1.5 * validation_x);
validation_y = validation_y + err;

% Create the first plot
subplot(4, 4, 1);

hold on;
plot(x, y);
scatter(test_x, test_y);
axis([0, 5, -5, 5]);
title('Function and data');
hold off;

% Do the lines of best fit
for degree = 1:10
   subplot(4, 4, degree + 1);
   
   hold on;
   % S contains the error
   p = polyfit(test_x, test_y, degree);
   y = polyval(p, x, S);
   plot(x, y);
   
   r = (validation_y - y) .^ 2;
   SSE = sum(r)
   
   scatter(validation_x, validation_y);
   axis([0, 5, -5, 5]);
   title(sprintf('Degree %d line fit', degree));
   hold off;
end