root = fileparts(mfilename('fullpath'));

if ~exist(fullfile(root,'examples'),'dir')
    mkdir(fullfile(root,'examples'));
end

run(fullfile(root,'preprocess_hkr.m'));
run(fullfile(root,'fit_hkr.m'));
run(fullfile(root,'generate_hkr.m'));
