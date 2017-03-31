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
data = d;

figure;
hold on;
% ksdensity(data, 'PlotFcn', 'contour');
plot(a(:, 1), a(:, 2), '+');
plot(b(:, 1), b(:, 2), 'o');

% Calculate the grid
[f, xi] = ksdensity(data);
x = linspace(min(xi(:, 1)),max(xi(:, 1)));
y = linspace(min(xi(:, 2)),max(xi(:, 2)));
[xq,yq] = meshgrid(x,y);
z = griddata(xi(:, 1),xi(:, 2),f,xq,yq);

% We now have x, y, z that can be used to get the gradient at any point

contour(x, y, z);



copy = data;

hold off;

shift([1, 1], d);

function [x, y] = shift(point, original_points)
    % The X shift
    s_x = 0.0;
    % The Y shift
    s_y = 0.0;
    % The scale factor
    sf = 0.0;

    s = size(original_points);

    for i = 1:s(1)
        for j = 1:s(2)
            p = original_points(i, j);
            dist = norm(p - point)
        end
    end

end
