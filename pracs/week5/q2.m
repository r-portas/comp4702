% Q2

a = randn(200, 2);
b = a + 4;
c = a;

c(:, 1) = 3 * c(:, 1);
c = c - 4;

d = [a; b];
e = [a; b; c];

% hold on;
% plot(a(:, 1), a(:, 2), '+');
% plot(b(:, 1), b(:, 2), 'o');
% plot(c(:, 1), c(:, 2), '*');

% Use the first dataset
data = e;


figure;
subplot(3, 2, 1);
hold on;
% ksdensity(data, 'PlotFcn', 'contour');
plot(a(:, 1), a(:, 2), '+');
plot(b(:, 1), b(:, 2), 'o');
plot(c(:, 1), c(:, 2), '*');

title('Contours Overlay');

% Calculate the grid
[f, xi] = ksdensity(data); x = linspace(min(xi(:, 1)),max(xi(:, 1)));
y = linspace(min(xi(:, 2)),max(xi(:, 2)));
[xq,yq] = meshgrid(x,y);
z = griddata(xi(:, 1),xi(:, 2),f,xq,yq);

% We now have x, y, z that can be used to get the gradient at any point

contour(x, y, z);
xlim([-10, 10]);
ylim([-10, 10]);
hold off;

copy = data;
new_points = copy;

for i = 1:5
    new_points = step(new_points, x, y, z);
    subplot(3, 2, i + 1);
    hold on;
    % ksdensity(data, 'PlotFcn', 'contour');
    scatter(new_points(:, 1), new_points(:, 2));
    title(sprintf('Step %d', i));
    xlim([-10, 10]);
    ylim([-10, 10]);
    hold off;

end


function dist = euclid_distance(point1, point2)
    dist = sqrt((point1(1) - point2(1))^2 + (point1(2) - point2(2))^2);
end

function new_points = step(points, x, y, z)
    max_distance = 1.8;
    new_points = zeros(length(points), 2);
    for i = 1:length(points)
        point = points(i, :);

        within_range = zeros(length(points), 1);

        numerator = 0;
        denominator = 0;

        for j = 1:length(points)
            other_point = points(j, :);
            if euclid_distance(point, other_point) < max_distance
                within_range(j) = 1;
                % weight = interp2(x, y, z, other_point(1), other_point(2));

                % Calculate part of sum
                distance = euclid_distance(point, other_point);
                numerator = numerator + (distance * other_point);
                denominator = denominator + distance;
            end
        end

        mx = numerator / denominator;
        new_points(i, :) = mx(1, :); 
    end
end
