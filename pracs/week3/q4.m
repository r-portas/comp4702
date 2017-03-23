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
    % figure;
    % hold on;
    % scatter(1:length(class1), class1);
    % scatter(1:length(class2), class2);
    % hold off;

    estimate_range = 1:0.1:8;

    class1_data = data;
    class1_data(class2 == 1) = NaN;

    class1_mle = mle(class1_data);
    class1_pdf = normpdf(estimate_range, class1_mle(1), class1_mle(2));

    class2_data = data;
    class2_data(class1 == 1) = NaN;

    class2_mle = mle(class2_data);
    class2_pdf = normpdf(estimate_range, class2_mle(1), class2_mle(2));


    figure;

    scatter(x_values, data);

    % Verify the classes are divided
    figure;

    hold on;

    yyaxis left;
    scatter(class1_data, x_values, 'r');
    scatter(class2_data, x_values, 'b');

    yyaxis right;
    plot(estimate_range, class1_pdf, 'r');
    plot(estimate_range, class2_pdf, 'b');
    legend('Iris Setosa', 'Iris Versicolor');
    hold off;

    % Plot the likelihood
    figure;
    hold on;
    plot(estimate_range, class1_pdf);
    plot(estimate_range, class2_pdf);
    xlim([1, 10]);

    title('Likelihoods');
    xlabel('x');
    ylabel('P(x|C_i)');

    p_class1 = class1_pdf ./ (class1_pdf + class2_pdf);
    length(x_values)
    p_class2 = class2_pdf ./ (class1_pdf + class2_pdf);

    figure;
    hold on

    plot(estimate_range, p_class1);
    plot(estimate_range, p_class2);
    
    hold off;
    
end
