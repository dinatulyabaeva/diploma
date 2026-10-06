root = fileparts(mfilename('fullpath'));
input_path = fullfile(root,'hkr_q.png');

I = imread(input_path);

if size(I,3) == 3
    I = rgb2gray(I);
end

BW = imbinarize(I);

if mean(BW(:)) > 0.5
    BW = ~BW;
end

BW = bwareaopen(BW,2);

CC = bwconncomp(BW);
numPixels = cellfun(@numel,CC.PixelIdxList);
[~,idx] = max(numPixels);

BW2 = false(size(BW));
BW2(CC.PixelIdxList{idx}) = true;

stats = regionprops(BW2,'BoundingBox');
cropped = imcrop(BW2,stats(1).BoundingBox);
cropped = padarray(cropped,[20 20],0);

img = imresize(cropped,[105 105],'nearest');
img = logical(img);

save(fullfile(root,'hkr_preprocessed.mat'),'img');

figure;
imshow(img);
axis off;
title('HKR preprocessed');

exportgraphics(gcf,fullfile(root,'examples','preprocessed.png'),'Resolution',200);
