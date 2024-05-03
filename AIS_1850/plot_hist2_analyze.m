function name=plot_hist2_analyze(steps,save_fig)

    if ~exist('save_fig','var')
     % if 1, save figures
      save_fig = 0;
    end

    % loadonly = 1;
    addpath('./../scripts');



    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
    p_table = 'Data/Tables/';
    % loadonly=1;
    % InterpFromMeshToMesh2d

    % clim runs 10-12c
    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');

    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday'),% {{{
        figname_in='PISM_1932-2030_from2ka';

        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
        make_3_best_plots(name,figname_in,save_fig);
    end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{
    name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';

    figname_in='Cmean_1930-2030_from2ka';
    make_3_best_plots(name,figname_in,save_fig);



end% }}}`
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x'),% {{{
    name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';

    figname_in='Cnn_1930-2030_from2ka';

    make_3_best_plots(name,figname_in,save_fig);

end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{

        figname_in='2INV_1932-2030_from2ka';

        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';
       

        make_3_best_plots(name,figname_in,save_fig);

    end% }}}

    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday_ocean95percentile'),% {{{

        figname_in='PISM_1932-2030_from2ka';
        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
        make_3_best_plots_ocean95percentile(name,figname_in,save_fig);
    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_ocean95percentile'),% {{{
        name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';
        figname_in='Cmean_1930-2030_from2ka';
        make_3_best_plots_ocean95percentile(name,figname_in,save_fig);



end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x_ocean95percentile'),% {{{

    name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';
    figname_in='Cnn_1930-2030_from2ka';
    make_3_best_plots_ocean95percentile(name,figname_in,save_fig);



end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_ocean95percentile'),% {{{
        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';
        figname_in='2INV_1932-2030_from2ka';
        make_3_best_plots_ocean95percentile(name,figname_in,save_fig);



    end% }}}

    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday_oceanPIG95percentile'),% {{{

        figname_in='PISM_1932-2030_from2ka';
        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
        make_3_best_plots_oceanPIG95percentile(name,figname_in,save_fig);

    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_oceanPIG95percentile'),% {{{
        name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';
        figname_in='Cmean_1930-2030_from2ka';
        make_3_best_plots_oceanPIG95percentile(name,figname_in,save_fig);



end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x_oceanPIG95percentile'),% {{{

    name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';
    figname_in='Cnn_1930-2030_from2ka';
    make_3_best_plots_oceanPIG95percentile(name,figname_in,save_fig);



end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_oceanPIG95percentile'),% {{{
        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';
        make_3_best_plots_oceanPIG95percentile(name,figname_in,save_fig);
        figname_in='2INV_1932-2030_from2ka';



    end% }}}
    % plot all the runs
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_plotall'),% {{{

        figname_in='2INV_1932-2030_from2ka';

        name = 'historic_clim_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';
        namenew = [p_table 'cond_clim_' name];

        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            mdin_path=['Models/' 'hist2_hist1_' T.model_names{i}];
            figname=[ 'hist2_hist1_' T.model_names{i}];
            md_in=loadmodel(mdin_path);
            plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
            plots_2d_all_transient(md_in,figname,save_fig);

        end
       

% make_3_best_plots(name,figname_in,save_fig);

    end% }}}
% plot all for 95 percetile
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_plotall_95oceanPIGprecneitle'),% {{{

        for i =1:21

            modelname  = ['hist2_hist1_historic_clim_oceanPIG95percentile_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            mdin_path = ['Models/' modelname];

            figname=modelname;
            md_in=loadmodel(mdin_path);
            plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
            plots_2d_all_transient(md_in,figname,save_fig);

        end

    end% }}}

if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_plotall'),% {{{
        for i =1:21

            modelname  = ['hist2_hist1_historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            mdin_path = ['Models/' modelname];

            figname=modelname;
            md_in=loadmodel(mdin_path);
            plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
            plots_2d_all_transient(md_in,figname,save_fig);

        end



end% }}}`
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x_plotall'),% {{{
        for i =1:21

            modelname  = ['hist2_hist1_historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat']
            mdin_path = ['Models/' modelname];

            figname=modelname;
            md_in=loadmodel(mdin_path);
            plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
            plots_2d_all_transient(md_in,figname,save_fig);

        end

end% }}}


if perform(org,'-1930_nobasal_melt_nonlocal_2ka_RedoforTHW_Cfriction_mean_SMB4x_cfrition0.25_specifictime'),% {{{
    directory = 'Models';
    files = dir(fullfile(directory, 'hist2_hist1_timeyear_*RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'));
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
    if perform(org,'-1930_mean_SMB4_submit_c0.5_specific'),% {{{
    directory = 'Models';
    files = dir(fullfile(directory, 'hist2_hist1_timeyear_*nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.5'));
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
    if perform(org,'-1930_mean_SMB4_submit_c0.25_specific'),% {{{
    directory = 'Models';
    files = dir(fullfile(directory, 'hist2_hist1_timeyear_*nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25'));
    % Loop through each file       
    for i = 1:length(files)        
        % Get the file name        
        filename = files(i).name;  
        md_in_path = [directory '/' filename];      
        md_in = loadmodel(md_in_path);              
        figname=filename;          
        plot_4glaciers_move_check_hist2(md_in,md_present,figname,save_fig)
        % plots_2d_all_transient(md_in,figname,save_fig);
    end    


    end% }}}
