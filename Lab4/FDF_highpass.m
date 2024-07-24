rows = 2;
cols = 4;
frequency = 40;

% 输入图像 pout.bmp、Girl.bmp
img1 = imread("images\pout.bmp");
img2 = imread("images\Girl.bmp");
subplot(rows, cols, 1); imshow(img1, []); title("Pout");
subplot(rows, cols, cols + 1); imshow(img2, []); title("Girl");

% 使用理想高通滤波器
ihpf1 = idealHighPassFilter(img1, frequency);
ihpf2 = idealHighPassFilter(img2, frequency);
subplot(rows, cols, 2); imshow(ihpf1, []); title("Pout (IHPF)");
subplot(rows, cols, cols + 2); imshow(ihpf2, []); title("Girl (IHPF)");

% 使用巴特沃斯高通滤波器
bhpf1 = butterworthHighPassFilter(img1, frequency);
bhpf2 = butterworthHighPassFilter(img2, frequency);
subplot(rows, cols, 3); imshow(bhpf1, []); title("Pout (BHPF)");
subplot(rows, cols, cols + 3); imshow(bhpf2, []); title("Girl (BHPF)");

% 使用高斯高通滤波器
ghpf1 = gaussianHighPassFilter(img1, frequency);
ghpf2 = gaussianHighPassFilter(img2, frequency);
subplot(rows, cols, 4); imshow(ghpf1, []); title("Pout (GHPF)");
subplot(rows, cols, cols + 4); imshow(ghpf2, []); title("Girl (GHPF)");

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

function result = idealHighPassFilter(img, frequency) % 理想高通滤波器
    result = frequencyFilter(img, @(dist) dist > frequency);
end

function result = butterworthHighPassFilter(img, frequency) % 巴特沃斯高通滤波器
    result = frequencyFilter(img, @(dist) 1 - 1 ./ (1 + ((dist ./ frequency) .^ 2)));
end

function result = gaussianHighPassFilter(img, frequency) % 高斯高通滤波器
    result = frequencyFilter(img, @(dist) 1 - exp(- (dist ./ frequency) .^ 2));
end
