img = imread("images\cameraman.bmp");

l = input("> Low: ");
h = input("> High: ");

histogram(img, "BinLimits", [l, h]);
