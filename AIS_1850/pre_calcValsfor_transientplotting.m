function pre_calcValsfor_transientplotting(steps)

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
    % plot all runs g.l.
    if perform(org,'calc_vals_for_mytest_my_plotting_functions_clim'),% {{{

        md = loadmodel('Models/historic_clim_from_9_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');



% pre_plot_calcVals(md,1);
        % pre_plot_calcVals(md,2);  % not basin id for clim
        pre_plot_calcVals(md,3);




    end% }}}
    if perform(org,'calc_vals_for_mytest_my_plotting_functions_hist1'),% {{{

        md = loadmodel('Models/hist1_historic_clim_from_9_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');



% pre_plot_calcVals(md,1);
% pre_plot_calcVals(md,2);
        pre_plot_calcVals(md,3);




    end% }}}
    if perform(org,'calc_vals_for_mytest_my_plotting_functions_hist2'),% {{{

        md = loadmodel('Models/hist2_hist1_historic_clim_from_9_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');



% pre_plot_calcVals(md,1);
% pre_plot_calcVals(md,2);
        pre_plot_calcVals(md,3);




    end% }}}
