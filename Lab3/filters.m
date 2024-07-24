% Noises:
%   pepper noise
%   gaussian noise
%   random noise
% Filters:
%   mean filter
%   super threshold averaging filter
%   median filter
%   super threshold median filter

rows = 3;
cols = 5;
threshold = 30;

% Add noises
img = imread("images\lena.bmp");
pepper = imnoise(img, "salt & pepper", 0.03);
gaussian = imnoise(img, "gaussian");
randNoise = rand(size(img)) * 255;
pixels = numel(img);
indices = ind2sub(size(img), randperm(pixels, round(0.03 * pixels)));
random = img;
random(indices) = randNoise(indices);

subplot(rows, cols, 1); imshow(pepper); title("Salt & Pepper noise");
subplot(rows, cols, 6); imshow(gaussian); title("Gaussian noise");
subplot(rows, cols, 11); imshow(random); title("Random noise");

% Mean filter
pepperMean = imfilter(pepper, fspecial("average", 3));
gaussianMean = imfilter(gaussian, fspecial("average", 3));
randomMean = imfilter(random, fspecial("average", 3));

subplot(rows, cols, 2); imshow(pepperMean); title("Salt & Pepper noise (Mean filter)");
subplot(rows, cols, 7); imshow(gaussianMean); title("Gaussian noise (Mean filter)");
subplot(rows, cols, 12); imshow(randomMean); title("Random noise (Mean filter)");

% Super threshold neighbor averaging filter
pepperThrMed = super_threshold_averaging(pepper, threshold);
gaussianThrMed = super_threshold_averaging(gaussian, threshold);
randomThrMed = super_threshold_averaging(random, threshold);

subplot(rows, cols, 3); imshow(pepperThrMed); title("Salt & Pepper noise (Super threshold averaging filter)");
subplot(rows, cols, 8); imshow(gaussianThrMed); title("Gaussian noise (Super threshold averaging filter)");
subplot(rows, cols, 13); imshow(randomThrMed); title("Random noise (Super threshold averaging filter)");

% Median filter
pepperMedian = medfilt2(pepper);
gaussianMedian = medfilt2(gaussian);
randomMedian = medfilt2(random);

subplot(rows, cols, 4); imshow(pepperMedian); title("Salt & Pepper noise (Median filter)");
subplot(rows, cols, 9); imshow(gaussianMedian); title("Gaussian noise (Median filter)");
subplot(rows, cols, 14); imshow(randomMedian); title("Random noise (Median filter)");

% Super threshold median filter
pepperThrMed = super_threshold_median(pepper, threshold);
gaussianThrMed = super_threshold_median(gaussian, threshold);
randomThrMed = super_threshold_median(random, threshold);

subplot(rows, cols, 5); imshow(pepperThrMed); title("Salt & Pepper noise (Super threshold median filter)");
subplot(rows, cols, 10); imshow(gaussianThrMed); title("Gaussian noise (Super threshold median filter)");
subplot(rows, cols, 15); imshow(randomThrMed); title("Random noise (Super threshold median filter)");

% Custom filter functions
function output_img = super_threshold_averaging(img, threshold)
    img = double(img);
    output_img = zeros(size(img));
    
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            row_min = max(i-1, 1);
            row_max = min(i+1, size(img, 1));
            col_min = max(j-1, 1);
            col_max = min(j+1, size(img, 2));
            
            neighborhood = img(row_min:row_max, col_min:col_max);
            avg_intensity = mean(neighborhood(:));
            
            if abs(img(i, j) - avg_intensity) > threshold
                output_img(i, j) = avg_intensity;
            else
                output_img(i, j) = img(i, j);
            end
        end
    end
    output_img = uint8(output_img);
end

function output_img = super_threshold_median(img, threshold)
    img = double(img);
    output_img = zeros(size(img));
    
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            row_min = max(i-1, 1);
            row_max = min(i+1, size(img, 1));
            col_min = max(j-1, 1);
            col_max = min(j+1, size(img, 2));
            
            neighborhood = img(row_min:row_max, col_min:col_max);
            median_intensity = median(neighborhood(:));
            
            if abs(img(i, j) - median_intensity) > threshold
                output_img(i, j) = median_intensity;
            else
                output_img(i, j) = img(i, j);
            end
        end
    end
    output_img = uint8(output_img);
end
