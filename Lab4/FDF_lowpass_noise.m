rows = 2;
cols = 4;
frequency = 30;

% 输入图像 Girl.bmp，加椒盐噪声、高斯噪声，产生有噪声图像
orig = imread("images\Girl.bmp");
img1 = imnoise(orig, "salt & pepper");
img2 = imnoise(orig, "gaussian");
subplot(rows, cols, 1); imshow(img1, []); title("Salt & Pepper");
subplot(rows, cols, cols + 1); imshow(img2, []); title("Gaussian");

% 使用理想低通滤波器
ilpf1 = idealLowPassFilter(img1, frequency);
ilpf2 = idealLowPassFilter(img2, frequency);
subplot(rows, cols, 2); imshow(ilpf1, []); title("Salt & Pepper (ILPF)");
subplot(rows, cols, cols + 2); imshow(ilpf2, []); title("Gaussian (ILPF)");

% 使用巴特沃斯低通滤波器
blpf1 = butterworthLowPassFilter(img1, frequency);
blpf2 = butterworthLowPassFilter(img2, frequency);
subplot(rows, cols, 3); imshow(blpf1, []); title("Salt & Pepper (BLPF)");
subplot(rows, cols, cols + 3); imshow(blpf2, []); title("Gaussian (BLPF)");

% 使用高斯低通滤波器
glpf1 = gaussianLowPassFilter(img1, frequency);
glpf2 = gaussianLowPassFilter(img2, frequency);
subplot(rows, cols, 4); imshow(glpf1, []); title("Salt & Pepper (GLPF)");
subplot(rows, cols, cols + 4); imshow(glpf2, []); title("Gaussian (GLPF)");

% 滤波器实现
function result = frequencyFilter(img, filterGen) % 频域滤波器通用代码
    [h, w] = size(img);
    [X, Y] = meshgrid(-w / 2 : w / 2 - 1, -h / 2 : h / 2 - 1);
    dist = hypot(X, Y);
    filter = filterGen(dist); % 使用 filterGen 函数根据 dist 生成滤镜
    f = fftshift(fft2(img));
    result = f .* filter;
    result = abs(ifft2(ifftshift(result)));
end

function result = idealLowPassFilter(img, frequency) % 理想低通滤波器
    result = frequencyFilter(img, @(dist) dist <= frequency);
end

function result = butterworthLowPassFilter(img, frequency) % 巴特沃斯低通滤波器
    result = frequencyFilter(img, @(dist) 1 ./ (1 + ((dist ./ frequency) .^ 2)));
end

function result = gaussianLowPassFilter(img, frequency) % 高斯低通滤波器
    result = frequencyFilter(img, @(dist) exp(- (dist ./ frequency) .^ 2));
end
