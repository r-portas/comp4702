load mnist_train;
my_error = NaN(1, 400);
idx = unidrnd(60000, 6000, 1);
x = train_X(idx, :);
labels = train_labels(idx);

data = zeros(30, 300);

[ydata, err] = tsne(x, labels, 2, 30, 300);
%for i = 1:30
%    [ydata, err] = tsne(x, labels, 2, 30, i * 10);
%    data(i, :) = err; 
%end

surf(data);
xlabel('Iterations');
ylabel('Perplexity (x10)');
