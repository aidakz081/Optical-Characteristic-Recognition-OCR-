% Read an image
imagePath = 'D:\DANESHGAH\term 5\Signals and Systems\Project\image.jpg';
img = imread(imagePath);

% Perform OCR on the image
ocrResults = ocr(img);

% Display the recognized text
recognizedText = ocrResults.Text;
disp(['Recognized Text: ' recognizedText]);

% Display bounding boxes around recognized words
figure;
imshow(img);
hold on;

% Plot bounding boxes
for i = 1:numel(ocrResults.Words)
    position = ocrResults.WordBoundingBoxes(i, :);
    rectangle('Position', position, 'EdgeColor', 'r', 'LineWidth', 2);
end

hold off;
title('OCR Results');