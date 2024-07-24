rows = 2;
cols = 5;

% 用 Fourier 变换算法，对 rect1.bmp 和 rect2.bmp 图像作二维 Fourier 变换并显示其频谱
% 要求对幅度作变换（由于高、低频幅度相差很大），将低频移到中心点。
img1 = imread("images\Rect1.bmp");
img2 = imread("images\Rect2.bmp");
subplot(rows, cols, 1); imshow(img1, []); title("Rect1.bmp");
subplot(rows, cols, cols + 1); imshow(img2, []); title("Rect2.bmp");

f1 = fft2(img1);
f2 = fft2(img2);
f1_s = log(abs(fftshift(f1)) + 1);
f2_s = log(abs(fftshift(f2)) + 1);
subplot(rows, cols, 2); imshow(f1_s, []); title("Rect1 centered spectrum");
subplot(rows, cols, cols + 2); imshow(f2_s, []); title("Rect2 centered spectrum");

%  用 Fourier 系数的幅度进行 Fourier 反变换，并显示其图像
if1_amp = uint8(ifft2(abs(f1)));
if2_amp = uint8(ifft2(abs(f2)));
subplot(rows, cols, 3); imshow(if1_amp, []); title("Rect1 amplitude IT");
subplot(rows, cols, cols + 3); imshow(if2_amp, []); title("Rect2 amplitude IT");

% 用 Fourier 系数的相位进行 Fourier 反变换，并显示其图像
% 比较结果，评价人眼对图像幅频特性和相频特性的敏感度
if1_phase = uint8(abs(ifft2(10000*exp(1i*angle(f1)))));
if2_phase = uint8(abs(ifft2(10000*exp(1i*angle(f2)))));
subplot(rows, cols, 4); imshow(if1_phase, []); title("Rect1 phase IT");
subplot(rows, cols, cols + 4); imshow(if2_phase, []); title("Rect2 phase IT");

% 将图像的 Fourier 变换置为其共轭后进行反变换，显示其图像，并与原始图像比较其差异
if1_conj = ifft2(conj(f1));
if2_conj = ifft2(conj(f2));
subplot(rows, cols, 5); imshow(if1_conj, []); title("Rect1 conjugate IT");
subplot(rows, cols, cols + 5); imshow(if2_conj, []); title("Rect2 conjugate IT");
