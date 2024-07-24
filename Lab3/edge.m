% 1: Original image
% 2: Roberts
% 3: Sobel
% 4: Prewitt
% 5: Laplace1
% 6: Laplace2
% 7: Canny

img = imread("images\lena.bmp");
subplot(2, 4, [1, 5]); imshow(img); title("Original image");

roberts = edge(img, "roberts");
subplot(2, 4, 2); imshow(roberts); title("Roberts");

sobel = edge(img, "sobel");
subplot(2, 4, 3); imshow(sobel); title("Sobel");

prewitt = edge(img, "prewitt");
subplot(2, 4, 4); imshow(prewitt); title("Prewitt");

laplace1 = imfilter(img, [0, 1, 0; 1, -4, 1; 0, 1, 0]);
subplot(2, 4, 6); imshow(laplace1); title("Laplace1");

laplace2 = imfilter(img, [-1, -1, -1; -1, 8, -1; -1, -1, -1]);
subplot(2, 4, 7); imshow(laplace2); title("Laplace2");

canny = edge(img, "canny");
subplot(2, 4, 8); imshow(canny); title("Canny");
