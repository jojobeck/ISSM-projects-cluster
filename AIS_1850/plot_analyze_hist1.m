function name=plot_analyze(steps,save_fig)

    if ~exist('save_fig','var')
     % if 1, save figures
      save_fig = 0;
    end

    % loadonly = 1;
    addpath('./../scripts');
    p_table = 'Data/Tables/';



    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
    datadir= '/Users/jbec0008/SAEF/datasets/';
    data_smb='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/preprocess/SMB_JOHANNA/';
    data_2km_xy='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/AtmosphericForcing/noresm1-m_rcp8.5/';
    data_ocean='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/Ocean/';
    data_tmp_ocean = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Ocean/';
    data_tmp_smb = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Atmosphere/';
    % loadonly=1;
    % InterpFromMeshToMesh2d

    % clim runs 10-12c
    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');
    % plot all runs g.l.
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_gl_to_presentday'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md_end ='_-1930_from_2ka_2INVCfriction_mean_SMB4_submit.mat'
        figname = '2Inv_1850_1930_from2kaPIG'
        plot_4glaciers(md_in,md_end,figname,save_fig)

    end% }}}
    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday'),% {{{
        figname='PISM_1859_1930_from2ka';

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md_end='_-1930_from_2ka_PISM_submit.mat';


        plot_4glaciers(md_in,md_end,figname,save_fig)
    end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{


    for i =1:21

            modelname  = ['hist1_historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            mdin_path = ['Models/' modelname];

            figname=modelname;
            md_in=loadmodel(mdin_path);
            plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
            plots_2d_all_transient(md_in,figname,save_fig);

    end


end% }}}`
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x'),% {{{

    for i =1:21

            modelname  = ['hist1_historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat']
            mdin_path = ['Models/' modelname];

            figname=modelname;
            md_in=loadmodel(mdin_path);
            plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
            plots_2d_all_transient(md_in,figname,save_fig);

    end


end% }}}
    if perform(org,'clim-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{

        name = 'historic_clim_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';
        namenew = [p_table 'cond_clim_' name];

        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            mdin_path=['Models/' 'hist1_' T.model_names{i}];
            figname=[ 'hist1_' T.model_names{i}];
            md_in=loadmodel(mdin_path);
            % plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
            plots_2d_all_transient(md_in,figname,save_fig);

        end




    end% }}}
% oceanpig95percentile
    if perform(org,'clim-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_95oceanPIGpercentile'),% {{{
        for i =1:21

            modelname  = ['hist1_historic_clim_oceanPIG95percentile_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            mdin_path = ['Models/' modelname];

            figname=modelname;
            md_in=loadmodel(mdin_path);
            plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
            plots_2d_all_transient(md_in,figname,save_fig);

        end




    end% }}}
    %p friction
if perform(orgA,'-1930_nobasal_melt_nonlocal_2ka_RedoforTHW_Cfriction_mean_SMB4x_cfrition0.75'),% {{{


    i =10;

    modelname  = ['hist1_historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.75']
    mdin_path = ['Models/' modelname];
    figname=modelname;
    md_in=loadmodel(mdin_path);
    plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
% plots_2d_all_transient(md_in,figname,save_fig);



end% }}}`
if perform(orgA,'-1930_nobasal_melt_nonlocal_2ka_RedoforTHW_Cfriction_mean_SMB4x_cfrition0.5'),% {{{


    i =10;

    modelname  = ['hist1_historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0-2ka_Cfriction_mean_SMB4x_cfriction0.5']
    mdin_path = ['Models/' modelname];
    figname=modelname;
    md_in=loadmodel(mdin_path);
    plot_4glaciers_move_check(md_in,md_present,figname,save_fig)
% plots_2d_all_transient(md_in,figname,save_fig);



end% }}}`
