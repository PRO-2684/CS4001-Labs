% 输入图像 alphabet1.jpg 及几何失真图像 alphabet2.jpg
% 设置控制点进行几何失真校正，显示校正后的图像

original = imread("images\alphabet1.jpg");
image = imread("images\alphabet2.jpg");

initMoving = [0.6875, 0.8125; 223.4375, 0.5625; 0.9375, 223.8125; 244.9375, 265.9375];
initFixed = [0.9375, 1.1875; 233.8125, 0.9375; 1.3125, 235.8125; 233.9375, 235.8125];
[moving, fixed] = cpselect(image, original, ...
    initMoving, initFixed, ...
    "Wait", true);
disp(moving);
disp(fixed);

t = fitgeotform2d(moving, fixed, "projective");
nearest = imwarp(image, t, "nearest");
bilinear = imwarp(image, t, "bilinear");
subplot(1, 2, 1); imshow(nearest); title("Nearest");
subplot(1, 2, 2); imshow(bilinear); title("Bilinear");
