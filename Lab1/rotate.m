% 根据输入的旋转角度参数，绕图像中心点旋转
% 分别用最近邻插值和双线性插值显示旋转后的图像。

image = imread("images\lena.bmp");
degree = input("Degree:");
nearest = imrotate(image, degree, "nearest", "crop");
bilinear = imrotate(image, degree, "bilinear", "crop");
subplot(1, 3, 1); imshow(image); title("Original");
subplot(1, 3, 2); imshow(nearest); title("Nearest");
subplot(1, 3, 3); imshow(bilinear); title("Bilinear");
