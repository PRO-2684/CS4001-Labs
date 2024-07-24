img = imread("images\cameraman.bmp");

x1 = input("> x1 = ");
y1 = input("> y1 = ");
x2 = input("> x2 = ");
y2 = input("> y2 = ");

mask1 = img < x1;                   % Where x < x1
mask2 = (img >= x1) & (img <= x2);  % Where x1 <= x <= x2
mask3 = img > x2;                   % Where x > x2

transformed = zeros(size(img));
transformed(mask1) ... 
    = y1 / x1 * img(mask1);
transformed(mask2) ...
    = ((y2 - y1) / (x2 - x1) * (img(mask2) - x1)) + y1;
transformed(mask3) ...
    = ((255 - y2) / (255 - x2) * (img(mask3) - x2)) + y2;

subplot(1, 2, 1); imshow(img); title('Original Image');
subplot(1, 2, 2); imshow(uint8(transformed)); title('Transformed Image');
