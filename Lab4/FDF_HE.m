rows = 2;
cols = 4;
frequency = 15;
k = 2; % 高频增强参数 1
b = 1; % 高频增强参数 2

% 读取原图
img = imread("images\pout.bmp");
subplot(rows, cols, [1, cols + 1]); imshow(img); title("Original");

% 先进行高频增强滤波，然后进行直方图均衡化
ihpf_histeq = histeq(uint8(idealHighPassFilter(img, frequency, k, b)));
bhpf_histeq = histeq(uint8(butterworthHighPassFilter(img, frequency, k, b)));
ghpf_histeq = histeq(uint8(gaussianHighPassFilter(img, frequency, k, b)));
subplot(rows, cols, 2); imshow(ihpf_histeq); title("IHPF then HistEq");
subplot(rows, cols, 3); imshow(bhpf_histeq); title("BHPF then HistEq");
subplot(rows, cols, 4); imshow(ghpf_histeq); title("GHPF then HistEq");

% 先进行直方图均衡化，然后进行高频增强滤波
histeq_img = histeq(img);
ihpf_histeq = idealHighPassFilter(histeq_img, frequency, k, b);
blpf_histeq = butterworthHighPassFilter(histeq_img, frequency, k, b);
glpf_histeq = gaussianHighPassFilter(histeq_img, frequency, k, b);
subplot(rows, cols, cols + 2); imshow(ihpf_histeq, []); title("HistEq then IHPF");
subplot(rows, cols, cols + 3); imshow(blpf_histeq, []); title("HistEq then BHPF");
subplot(rows, cols, cols + 4); imshow(glpf_histeq, []); title("HistEq then GHPF");

% 增强滤波器实现
function result = frequencyFilter(img, filterGen, k, b) % 通用代码
    [h, w] = size(img);
    [X, Y] = meshgrid(-w / 2 : w / 2 - 1, -h / 2 : h / 2 - 1);
    dist = hypot(X, Y);
    filter = filterGen(dist); % 使用 filterGen 函数根据 dist 生成滤镜
    filter = k * filter + b;
    f = fftshift(fft2(img));
    result = f .* filter;
    result = abs(ifft2(ifftshift(result)));
end

function result = idealHighPassFilter(img, frequency, k, b) % 理想高通滤波器
    result = frequencyFilter(img, @(dist) dist > frequency, k, b);
end

function result = butterworthHighPassFilter(img, frequency, k, b) % 巴特沃斯高通滤波器
    result = frequencyFilter(img, @(dist) 1 - 1 ./ (1 + ((dist ./ frequency) .^ 2)), k, b);
end

function result = gaussianHighPassFilter(img, frequency, k, b) % 高斯高通滤波器
    result = frequencyFilter(img, @(dist) 1 - exp(- (dist ./ frequency) .^ 2), k, b);
end