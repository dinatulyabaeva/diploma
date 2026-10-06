root = fileparts(mfilename('fullpath'));

load(fullfile(root,'hkr_preprocessed.mat'),'img');

K = 5;
verbose = true;
include_mcmc = true;
fast_mode = true;

G_hkr = fit_motorprograms(img,K,verbose,include_mcmc,fast_mode);

save(fullfile(root,'G_hkr_character.mat'),'G_hkr','-v7.3');
