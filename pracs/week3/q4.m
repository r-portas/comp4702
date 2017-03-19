function q4(data, class)
    class_names = unique(class);
    x_values = 1:length(class);
    
    class1 = zeros(1, length(class));
    class2 = zeros(1, length(class));

    for i = x_values
        if strcmp(class{i}, class_names{1})
            class1(i) = 1;
        else
            class2(i) = 1;
        end
    end

    % Verify the classes are correct
    % scatter(1:length(class1), class1);
    % scatter(1:length(class2), class2);

    class1_data = data;
    class1_data(class2 == 1) = NaN;

    class1_mle = mle(class1_data);
    class1_pdf = normpdf(x_values, class1_mle(1), class1_mle(2));

    class2_data = data;
    class2_data(class1 == 1) = NaN;

    class2_mle = mle(class2_data);
    class2_pdf = normpdf(x_values, class2_mle(1), class2_mle(2));

    % Verify the classes are divided
    figure;

    subplot(1, 2, 1);
    hold on;
    scatter(x_values, class1_data);
    scatter(x_values, class2_data);
    legend('Iris Setosa', 'Iris Versicolor');
    ylim([0, 10]);
    hold off;

    subplot(1, 2, 2);
    hold on;
    plot(class1_pdf, x_values);
    plot(class2_pdf, x_values);
    ylim([0, 10]);
    hold off;
    hold off;

    % Plot the likelihood
    figure;
    hold on;
    plot(x_values, class1_pdf);
    plot(x_values, class2_pdf);
    xlim([1, 10]);

    title('Likelihoods');
    xlabel('x');
    ylabel('P(x|C_i)');
    
    hold off;

    
end
