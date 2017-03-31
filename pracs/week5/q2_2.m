% Q2

a = randn(200, 2);
b = a + 4;
c = a;

c(:, 1) = 3 * c(:, 1);
c = c - 4;

d = [a; b];
e = [a; b; c];

% Use the first dataset
data = d;

% The density along the x axis
[fx, xx] = ksdensity(data(:, 1));

% The density along the y axis
[fy, xy] = ksdensity(data(:, 2));

% Plot the data
subplot(2, 1, 1);
hold on;
scatter(data(:, 1), zeros(1, length(data(:, 1))));
plot(xx, fx, 'b');

title('X Kernel Density')
legend('Raw data', 'Density');
hold off;

subplot(2, 1, 2);
hold on;
scatter(data(:, 2), zeros(1, length(data(:, 1))));
plot(xy, fy, 'b');
title('Y Kernel Density')
legend('Raw data', 'Density');
hold off;


copy = data;

distance = 0.5;

for i = 1:length(data(:, 1))
    x = data(i, 1);
    near = abs(copy(:, 1) - x) < distance;

    numerator = 0;
    denominator = 0;
    for j = 1:length(near)
        if near(j) == 1
            neighbour = data(j);
            distance = abs(neighbour - x);
            % Somehow index the gx here
        end
    end
end

for i = 1:length(data(:, 2))
    y = data(i, 2);
end
