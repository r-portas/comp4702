% Plot f(x) = 2*sin(1.5x)

x = linspace(0, 5);
y = 2 * sin(1.5 * x);


num = 20;

% Calculate the random readings
err = randn(num, 1);
upper = 5;
lower = 0;
rand_x = (upper - lower) .* rand(num, 1) + lower;
rand_y = 2 * sin(1.5 * rand_x);
rand_y = rand_y + err;


% Create the first plot
subplot(2, 2, 1);

hold on;
plot(x, y);
scatter(rand_x, rand_y);
axis([0, 5, -5, 5]);
title('(a) Function and data');
hold off;
