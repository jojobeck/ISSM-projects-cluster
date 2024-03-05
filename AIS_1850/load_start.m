 addpath('./../scripts');
 name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
% results = analyze_hist2_exp(name);

md_hist = loadmodel('Models/hist2_historic_from_3_-1930_from_2ka_PISM_submit.mat');
md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');
dist_gl_presentday = reinitializelevelset(md_present, md_present.mask.ocean_levelset);
