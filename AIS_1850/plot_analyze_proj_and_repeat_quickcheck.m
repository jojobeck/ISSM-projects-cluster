function name= plot_analyze_proj_and_repeat_quickcheck(steps,save_fig)

    if ~exist('save_fig','var')
     % if 1, save figures
      save_fig = 0;
    end

    % loadonly = 1;
    addpath('./../scripts');



    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
    p_table = 'Data/Tables/';
    % loadonly=1;
    % InterpFromMeshToMesh2d

    % clim runs 10-12c
    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');


if perform(org,'proj_best_glaciers'),% {{{
    directory = 'Models';
    files = dir(fullfile(directory, 'proj2100_hist2_hist1_timeyear*'));
    % Loop through each file
    for i = 1:length(files)
        % Get the file name
        filename = files(i).name;
        md_in_path = [directory '/' filename];
        md_in = loadmodel(md_in_path);
        figname=filename;
        plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
        % plots_2d_all_transient(md_in,figname,save_fig);
    end



end% }}}
if perform(org,'repeat_best_glaciers'),% {{{
    directory = 'Models';
    files = dir(fullfile(directory, 'repeat1850_timeyear*'));
    % Loop through each file
    for i = 1:length(files)
        % Get the file name
        filename = files(i).name;
        md_in_path = [directory '/' filename];
        md_in = loadmodel(md_in_path);
        figname=filename;
        plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
        % plots_2d_all_transient(md_in,figname,save_fig);
    end



end% }}}
