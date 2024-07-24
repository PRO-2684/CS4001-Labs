% 根据输入的水平和垂直缩放量，分别用最近邻插值和双线性插值，显示缩放后的图像

image = imread("images\lena.bmp");
sx = input("ScaleX:");
sy = input("ScaleY:");
dims = size(image) .* [sy, sx];

nearest = imresize(image, dims, "nearest");
bilinear = imresize(image, dims, "bilinear");
subplot(3, 1, 1); imshow(image); title("Original");
subplot(3, 1, 2); imshow(nearest); title("Nearest");
subplot(3, 1, 3); imshow(nearest); title("Bilinear");
