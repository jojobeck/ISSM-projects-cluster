function name=plot_analyze(steps,save_fig)

    if ~exist('save_fig','var')
     % if 1, save figures
      save_fig = 0;
    end

    % loadonly = 1;
    addpath('./../scripts');



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
    if perform(org,'clim_from_2ka_Cfriction_mean_2INV_SMB4_cfirciton_p0.75'),% {{{

        md=loadmodel('Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.75');
        figname=['Advance_',md.miscellaneous.name];
        plot_4glaciers_advance(md,md_present,figname,save_fig)  

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_2INV_SMB4_cfirciton_p0.5'),% {{{

        md=loadmodel('Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.5');
        figname=['Advance_',md.miscellaneous.name];
        plot_4glaciers_advance(md,md_present,figname,save_fig)  

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_2INV_SMB4_cfirciton_p0.25'),% {{{

        md=loadmodel('Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25');
        figname=['Advance_',md.miscellaneous.name];
        plot_4glaciers_advance(md,md_present,figname,save_fig)  

    end% }}}

    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_cfirciton_p0.75'),% {{{

        md=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.75');
        figname=['Advance_',md.miscellaneous.name];
        plot_4glaciers_advance(md,md_present,figname,save_fig)  

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_cfirciton_p0.5'),% {{{

        md=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.5');
        figname=['Advance_',md.miscellaneous.name];
        plot_4glaciers_advance(md,md_present,figname,save_fig)  

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_cfirciton_p0.25'),% {{{

        md=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25');
        figname=['Advance_',md.miscellaneous.name];
        plot_4glaciers_advance(md,md_present,figname,save_fig)  

    end% }}}
% if perform(org,'clim_from_2ka_2INVCfriction_mean_SMB4'),% {{{

% md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
% make_3_all_clim_plot(md_in,md_present,save_fig)


% end% }}}

