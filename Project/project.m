% Read the image
I = imread('C:\Users\Datis\Desktop\OCR Project\Project\image2.jpg');

% Convert the image to grayscale
I = rgb2gray(I);

% Convert the image to a binary image
binaryImage = imbinarize(I);

% Display the original and binary images side by side
figure;
subplot(1, 2, 1);
imshow(I);
title('Original Image');
subplot(1, 2, 2);
imshow(binaryImage);
title('Binary Image');

% Create a logical matrix
A = logical([1 1 0; 0 1 1; 1 0 1]);

% Find the indices of the zero elements in each column
zeroIndices = find(sum(binaryImage == 0, 1) > 0);

% Display the indices of the columns containing zero
disp(['The columns containing zero are columns ', num2str(zeroIndices), '.']);

% Find the start and end indices of each continuous sequence of zero indices
diffIndices = diff(zeroIndices);
startIndices = zeroIndices([1 find(diffIndices > 1) + 1]);
endIndices = zeroIndices([find(diffIndices > 1) length(zeroIndices)]);

% Display the start and end indices of each continuous sequence of zero indices
for i = 1:length(startIndices)
    disp(['Sequence ', num2str(i), ': columns ', num2str(startIndices(i)), ' to ', num2str(endIndices(i)), '.']);
end

% Split the matrix into submatrices based on the start and end indices
subMatrices = arrayfun(@(x,y) binaryImage(:,x:y), startIndices, endIndices, 'UniformOutput', false);

% Display the submatrices
for i = 1:length(subMatrices)
    % Find the rows that contain all ones
    onesRows = all(subMatrices{i} == 1, 2);
    countOfOneRowsOnTop = 0;
    countOfOneRowsInBottom = 0;
    for j = 1:length(onesRows)
        if onesRows(j,1) == 0
            countOfOneRowsOnTop = j;
            break;
        end
    end
    for j = length(onesRows): -1 : 1
        if onesRows(j,1) == 0
            countOfOneRowsInBottom = size(subMatrices{i}, 1) - j;
            break;
        end
    end

    % Remove the rows that contain all ones
    subMatrices{i} = subMatrices{i}(countOfOneRowsOnTop: size(subMatrices{i}, 1) - countOfOneRowsInBottom , :);

    disp(['Submatrix ', num2str(i), ':']);
    disp(subMatrices{i});
end



