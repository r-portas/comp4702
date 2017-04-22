clear all; close all; clc;
load mnist_train;
my_error = NaN(1, 400);
idx = unidrnd(60000, 6000, 1);
x = train_X(idx, :);
labels = train_labels(idx);
tsne(x, labels, 2, 30, 30);
