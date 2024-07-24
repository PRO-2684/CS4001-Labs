% 对图像 cameraman.bmp 采用四叉树表达的迭代区域分裂合并算法进行分割

N = 3;
C = .35;
I = imread("images\cameraman.bmp"); %原图
dims = [64 32 16 8 4 2];
subplot(1, N, 1); imshow(I); title("Original");
S = qtdecomp(I, C, 2); % 四叉树分割后的稀疏矩阵
blocks = zeros(256);

for dim = dims
    numBlocks = length(find(S == dim));
    if (numBlocks > 0)
        values = repmat(uint8(1), [dim dim numBlocks]);
        values(2:dim, 2:dim, :) = 0;
        blocks = qtsetblk(blocks, S, dim, values); % 设置各个块的边界
    end
end

decomposited = repmat(uint8(0), size(S));
decomposited(blocks == 1) = 255;
subplot(1, N, 2); imshow(decomposited, []); title("Decomposition");

i = 0;

% 标记
for dim = dims
    [vals, row, col] = qtgetblk(I, S, dim);
    if ~isempty(vals)
        for j = 1 : length(row)
            i = i + 1;
            blocks(row(j) : row(j) + dim - 1,col(j) : col(j) + dim - 1) = i;
        end
    end
end

% 合并极差较小的块的标记
for j = 1 : i
    bound = boundarymask(blocks == j, 4) & (~(blocks == j));
    [row, col] = find(bound == 1);
    for k = 1 : size(row, 1)
        merge = I((blocks == j) | (blocks == blocks(row(k), col(k))));
        if(range(merge(:)) < C * 256)
            blocks(blocks == blocks(row(k), col(k))) = j;
        end
    end
end

% 根据之前的标记重新分割
merged = repmat(uint8(0), size(S));
for i = 2 : 255
    for j = 2 : 255
        if(blocks(i, j) ~= blocks(i, j + 1) || blocks(i, j) ~= blocks(i + 1, j))
            merged(i, j) = 255;
        end
    end
end
subplot(1, N, 3); imshow(merged, []); title("Merged");
