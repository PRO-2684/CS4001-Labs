% 对图像 flower1.jpg 设置运动位移 30 个像素、运动方向 45 度，产生运动模糊图像
% 对其采用逆滤波和维纳滤波进行恢复，显示、对比分析恢复结果图像。
% 对产生的运动模糊图像加高斯噪声，产生有噪声图像
% 分别对其采用逆滤波和维纳滤波进行恢复，显示、对比分析恢复结果图像。

LEN = 30;
THETA = 45;
NOISE_MEAN = 0;
NOISE_VAR = 0.0001;
PSF = fspecial("motion", LEN, THETA); % 运动模糊滤镜

% 原图
original = im2double(imread("images\flower1.jpg"));
subplot(2, 4, [1, 5]); imshow(original); title("Original")

% 运动模糊
motion_blurred = imfilter(original, PSF, "conv", "circular");
subplot(2, 4, 2); imshow(motion_blurred); title("Motion Blurred");

% 运动模糊的逆滤波
inv = deconvwnr(motion_blurred, PSF, 0);
subplot(2, 4, 3); imshow(inv); title("Inverse Filter");

% 运动模糊的维纳滤波
wiener = deconvwnr(motion_blurred, PSF);
subplot(2, 4, 4); imshow(wiener); title("Wiener Filter");

% 运动模糊+高斯噪声
noisy = imnoise(motion_blurred, "gaussian", NOISE_MEAN, NOISE_VAR);
subplot(2, 4, 6); imshow(noisy); title("Motion Blurred + Noisy");

% 运动模糊+高斯噪声的逆滤波
inv = deconvwnr(noisy, PSF, 0);
subplot(2, 4, 7); imshow(inv); title("Inverse Filter");

% 运动模糊+高斯噪声的维纳滤波
estimated_nsr = NOISE_VAR / var(original(:));
wiener = deconvwnr(noisy, PSF, estimated_nsr);
subplot(2, 4, 8); imshow(wiener); title("Wiener Filter");
