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
    % plot all runs g.l.
    if perform(org,'test_my_plotting_functions'),% {{{

        md = loadmodel('Models/ISMIP6Antarctica_Test_groundonline_flux_output.mat');


        figname=[ 'Test_groundonline_flux_output'];

        % plots_2d_all_transient(md,figname,save_fig);
plot_transient_values_with_aggregratedValues(md,2,save_fig)
% plot_transient_values_with_aggregratedValues(md,3,save_fig)
% plot_transient_values_with_aggregratedValues(md,4,save_fig)
% plot_transient_values_with_aggregratedValues(md,5,save_fig)
% plot_transient_values_with_aggregratedValues(md,6,save_fig)
% plot_transient_values_with_aggregratedValues(md,7,save_fig)





    end% }}}
