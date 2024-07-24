% 输入一幅图像，根据输入的水平和垂直平移量，显示平移后的图像

image = imread("images\lena.bmp");
dx = input("TranslateX:");
dy = input("TranslateY:");
result = imtranslate(image, [dx, dy]);
subplot(2, 1, 1); imshow(image); title("Original");
subplot(2, 1, 2); imshow(result); title("Translated");
