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

nrow = ceil(sqrt(nsamp));

subplot(nrow+1,nrow,floor((nrow+1)/2));
plot_image_only(G_hkr.img);
title('Original HKR');

for i = 1:nsamp
    subplot(nrow+1,nrow,i+nrow);
    I = samples_hkr{i}.pimg > 0.5;
    plot_image_only(I);
    title(sprintf('BPL synthetic %d',i));
end

sgtitle('BPL one-shot generation for HKR');

exportgraphics(gcf,fullfile(out_dir,'generated_grid.png'),'Resolution',200);

for i = 1:nsamp
    I = samples_hkr{i}.pimg > 0.5;
    imwrite(I,fullfile(out_dir,sprintf('synthetic_%02d.png',i)));
end

imwrite(G_hkr.img,fullfile(out_dir,'original_hkr.png'));
save(fullfile(root,'generated_samples.mat'),'samples_hkr','types_hkr','-v7.3');
