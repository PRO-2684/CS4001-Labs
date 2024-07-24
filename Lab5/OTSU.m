% 对图像 lena.bmp 采用大津法（OTSU）自动选取阈值进行分割，显示分割二值化结果图像

original = imread("images\lena.bmp"); % 原图
subplot(1, 2, 1); imshow(original); title("Original");

thre = graythresh(original); % OTSU 计算合适阈值
binary = imbinarize(original, thre); % 根据阈值二值化
subplot(1, 2, 2); imshow(binary); title("Binary");
