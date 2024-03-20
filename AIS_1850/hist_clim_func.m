function md=run_func(steps,loadonly)
    if ~exist('loadonly','var')
     % loadonly parameter does not exist, so default it to something
      loadonly = 1;
    end


    % loadonly = 1;
    addpath('./../scripts');



    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
    % loadonly=1;
    % InterpFromMeshToMesh2d

    % clim runs normal melt
    if perform(org,'clim_from_2ka_PISM_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md = model_hist_clim_exp(md_in,loadonly);

    end% }}}
    if perform(org,'clim_from_2ka_PISM_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md = model_hist_clim_exp_load(md_in,loadonly);

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_nn_SMB4_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
        md = model_hist_clim_exp(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_nn_SMB4_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
        md = model_hist_clim_exp_load(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_2ka_2INVCfriction_mean_SMB4_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_2INVCfriction_mean_SMB4_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_1ka_2INVCfriction_mean_SMB4_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp(md_in,loadonly);           



    end% }}}
    if perform(org,'clim_from_1ka_2INVCfriction_mean_SMB4_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load(md_in,loadonly);           

    end% }}}

    % clim runs 95 percentile melt
    if perform(org,'clim_from_2ka_PISM_submit_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md = model_hist_clim_exp_ocean95percentile(md_in,loadonly);

    end% }}}
    if perform(org,'clim_from_2ka_PISM_load_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md = model_hist_clim_exp_load_ocean95percentile(md_in,loadonly);

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_nn_SMB4_submit_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
        md = model_hist_clim_exp_ocean95percentile(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_nn_SMB4_load_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
        md = model_hist_clim_exp_load_ocean95percentile(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_submit_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_ocean95percentile(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_load_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load_ocean95percentile(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_2ka_2INVCfriction_mean_SMB4_submit_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_ocean95percentile(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_2INVCfriction_mean_SMB4_load_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load_ocean95percentile(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_1ka_2INVCfriction_mean_SMB4_submit_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_ocean95percentile(md_in,loadonly);           



    end% }}}
    if perform(org,'clim_from_1ka_2INVCfriction_mean_SMB4_load_ocean95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load_ocean95percentile(md_in,loadonly);           

    end% }}}
    % clim runs PIG 95 percentile melt
    if perform(org,'clim_from_2ka_PISM_submit_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md = model_hist_clim_exp_oceanPIG95percentile(md_in,loadonly);

    end% }}}
    if perform(org,'clim_from_2ka_PISM_load_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md = model_hist_clim_exp_load_oceanPIG95percentile(md_in,loadonly);

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_nn_SMB4_submit_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
        md = model_hist_clim_exp_oceanPIG95percentile(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_nn_SMB4_load_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
        md = model_hist_clim_exp_load_oceanPIG95percentile(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_submit_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_oceanPIG95percentile(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4_load_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load_oceanPIG95percentile(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_2ka_2INVCfriction_mean_SMB4_submit_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_oceanPIG95percentile(md_in,loadonly);           


    end% }}}
    if perform(org,'clim_from_2ka_2INVCfriction_mean_SMB4_load_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load_oceanPIG95percentile(md_in,loadonly);           

    end% }}}
    if perform(org,'clim_from_1ka_2INVCfriction_mean_SMB4_submit_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_oceanPIG95percentile(md_in,loadonly);           



    end% }}}
    if perform(org,'clim_from_1ka_2INVCfriction_mean_SMB4_load_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md = model_hist_clim_exp_load_oceanPIG95percentile(md_in,loadonly);           

    end% }}}
    %change the friction coefficient of cmean
    if perform(org,'clim_from_0_2ka_2INVCfriction_mean_SMB4_submit_c0.75'),% {{{
        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.75');
        md = model_hist_clim_exp_from0_2ka(md_in,loadonly);    



    end% }}}
    if perform(org,'clim_from_0-2ka_2INVCfriction_mean_SMB4_submit_c0.5'),% {{{
        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.5');
        md = model_hist_clim_exp_from0_2ka(md_in,loadonly);    



    end% }}}
    if perform(org,'clim_from_0_2ka_2INVCfriction_mean_SMB4_submit_c0.25'),% {{{
        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25');
        md = model_hist_clim_exp_from0_2ka(md_in,loadonly);    



    end% }}}
    if perform(org,'clim_from_0_2ka_Cfriction_mean_SMB4_submit_c0.75'),% {{{
        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.75');
        md = model_hist_clim_exp_from0_2ka(md_in,loadonly);    



    end% }}}
    if perform(org,'clim_from_0_2ka_Cfriction_mean_SMB4_submit_c0.5'),% {{{
        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.5');
        md = model_hist_clim_exp_from0_2ka(md_in,loadonly);    



    end% }}}
    if perform(org,'clim_from_0_2ka_Cfriction_mean_SMB4_submit_c0.25'),% {{{
        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25');
        md = model_hist_clim_exp_from0_2ka(md_in,loadonly);    



    end% }}}
