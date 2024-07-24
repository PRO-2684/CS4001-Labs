img = imread("images\cameraman.bmp");

k = input("> k = ");
b = input("> b = ");

transformed = uint8(k * img + b);

subplot(1, 2, 1); imshow(img); title('Original Image');
subplot(1, 2, 2); imshow(transformed); title('Transformed Image');
