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
test_expected_y = 2 * sin(1.5 * test_x);
test_y = test_expected_y + err;

% Validation data
validation_x = (upper - lower) .* rand(num, 1) + lower;
validation_expected_y = 2 * sin(1.5 * validation_x);
validation_y = validation_expected_y + err;

% Create the first plot
figure;

hold on;
plot(x, y);
scatter(test_x, test_y);
axis([0, 5, -5, 5]);
title('Function and data');
hold off;

SSE_list_validation = zeros(1, 9);
SSE_list_test = zeros(1, 9);

% Do the lines of best fit
for degree = 1:9
   subplot(3, 3, degree);
   
   hold on;
   % Fit to the testing data
   p = polyfit(test_x, test_y, degree);
   % p = polyfit(validation_x, validation_y, degree);
   y = polyval(p, x);
   plot(x, y);
   
   % Calculate the error on the validation data
   r = (validation_y - polyval(p, validation_x)) .^ 2;
   SSE_val = sum(r);
   SSE_list_validation(degree) = SSE_val;

   r2 = (test_y - polyval(p, test_x)) .^ 2;
   SSE_test = sum(r2);
   SSE_list_test(degree) = SSE_test;
   
   scatter(validation_x, validation_y, 'b');
   scatter(test_x, test_y, 'r');
   legend('Legend of Best Fit', 'Validation Data', 'Testing Data');
   axis([0, 5, -5, 5]);
   title(sprintf('Degree %d line fit, %f', degree, SSE_val));
   hold off;
end

figure;

% Plot the error over polynomial degrees

hold on;

SSE_list_test
SSE_list_validation

plot(1:9, SSE_list_validation);
plot(1:9, SSE_list_test);
title('Error as a function of model order');
xlabel('Polynomial degree');
ylabel('SSE Error');
legend('Validation data error', 'Testing data error');
hold off;

