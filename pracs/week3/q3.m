% Q2: Boston Housing Data

load('housing.data');


%Change these two lines to specify amount of data
% This time only use the first half
x = housing(1:end/2, 6);
y = housing(1:end/2, 14);

SSE_list = zeros(1, 5);

hold on;
scatter(x, y);

for degree = 1:5
    p = polyfit(x, y, degree);
    best_fit = polyval(p, x);

    plot(x, best_fit);

    r = (y - best_fit) .^ 2;
    SSE = sum(r);

    SSE_list(degree) = SSE;
end

figure;

% Plot the error over polynomial degrees

hold on;

bar(1:5, SSE_list);
title('Error as a function of model order');
xlabel('Polynomial degree');
ylabel('SSE Error');
hold off;

hold off;
