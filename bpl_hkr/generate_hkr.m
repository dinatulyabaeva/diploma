root = fileparts(mfilename('fullpath'));

load(fullfile(root,'hkr_preprocessed.mat'),'img');
load(fullfile(root,'G_hkr_character.mat'),'G_hkr');

lib = loadlib;
nsamp = 9;

[samples_hkr,types_hkr] = task_generate_exemplars_1overk(G_hkr,lib,nsamp);

out_dir = fullfile(root,'examples');

if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

figure('Color','w');

subplot(4,3,2);
imshow(img);
axis off;
title('Original HKR');

for i = 1:nsamp
    subplot(4,3,i+3);
    if iscell(samples_hkr)
        sample = samples_hkr{i};
    else
        sample = samples_hkr(:,:,i);
    end
    imshow(sample);
    axis off;
    title(sprintf('BPL synthetic %d',i));
end

sgtitle('BPL one-shot generation for HKR');

exportgraphics(gcf,fullfile(out_dir,'generated_grid.png'),'Resolution',200);

for i = 1:nsamp
    if iscell(samples_hkr)
        sample = samples_hkr{i};
    else
        sample = samples_hkr(:,:,i);
    end
    imwrite(sample,fullfile(out_dir,sprintf('synthetic_%02d.png',i)));
end

imwrite(img,fullfile(out_dir,'original_hkr.png'));
save(fullfile(root,'generated_samples.mat'),'samples_hkr','types_hkr','-v7.3');
