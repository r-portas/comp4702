
%%Read in image
image_name = '28x28_8.bmp';

myImageInput = imread(image_name);
myImageVec = reshape((1-myImageInput)',1,784);


%%Perform classification

%Ensure you have this function 'mnist_example_classifier'
% saved in working directory - generated from output of nprtool
myImageOutputs = mnist_example_classifier(myImageVec); 
myImageProbabilities=myImageOutputs/sum(myImageOutputs);

%%Show the results

%Plot the image
figure
imshow(reshape(1-myImageVec,  28,28)') ;
title(sprintf('Input image: %s',image_name))

%Plot the output
figure
bar(0:9,myImageProbabilities)
title(sprintf('Classified image probabilities: %s',image_name))
xlabel('Written Number')
ylabel('Probability')

