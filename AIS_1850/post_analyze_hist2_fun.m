function post_analayze_hist2_func(steps)
    addpath('./../scripts');



    % parpool('local', numberOfWorkers);

    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;

    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday'),% {{{

        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
        weight_analyze_hist2_exp(name);
    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{
        name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';

        weight_analyze_hist2_exp(name);


    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x'),% {{{

        name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';
        weight_analyze_hist2_exp(name);


    end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{
        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';
        weight_analyze_hist2_exp(name);
    end% }}}

    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday_ocean95percentile'),% {{{

        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
        weight_analyze_hist2_exp_ocean95percentile(name);
    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_ocean95percentile'),% {{{
        name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';

        weight_analyze_hist2_exp_ocean95percentile(name);


end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x_ocean95percentile'),% {{{

    name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';

        weight_analyze_hist2_exp_ocean95percentile(name);


end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_ocean95percentile'),% {{{
        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';


        weight_analyze_hist2_exp_ocean95percentile(name);

    end% }}}

    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday_oceanPIG95percentile'),% {{{

        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
        weight_analyze_hist2_exp_oceanPIG95percentile(name);

    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_oceanPIG95percentile'),% {{{
        name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';

        weight_analyze_hist2_exp_oceanPIG95percentile(name);


end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x_oceanPIG95percentile'),% {{{

    name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';

        weight_analyze_hist2_exp_oceanPIG95percentile(name);


end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_oceanPIG95percentile'),% {{{
        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';


        weight_analyze_hist2_exp_oceanPIG95percentile(name);

    end% }}}
