img = imread("images\pout.bmp");

mu = 127;   % 高斯分布均值
sigma = 45; % 高斯分布标准差

equalized = histeq(img);
regulated = histeq(img, normpdf(0:1:255, mu, sigma));

subplot(3, 2, 1); imshow(img); title('Original Image');
subplot(3, 2, 2); histogram(img); title('Original Histogram');
subplot(3, 2, 3); imshow(equalized); title('Equalized Image');
subplot(3, 2, 4); histogram(equalized); title('Equalized Histogram');
subplot(3, 2, 5); imshow(regulated); title('Regulated Image');
subplot(3, 2, 6); histogram(regulated); title('Regulated Histogram');
