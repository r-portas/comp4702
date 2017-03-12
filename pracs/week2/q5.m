% Generate 1000 random numbers from a normal distribution with mean of 2 and StdDev of 4
nums = 4 .* randn(1000, 1) + 2;

% Verify mean and StdDev
mean(nums)
std(nums)

% Draw a histogram with 30 bins
histogram(nums, 30);

% Set the labels
xlabel('Random Variable');
ylabel('Frequency');
