function name=post_analyze_clim(steps,CLUSTER)
    if ~exist('CLUSTER','var')
     % if 1, save figures
      CLUSTER=0;
    end
    cluster_path='/Users/jbec0008/mnt/ncihome/SAEF/issm_projects/AIS_1850/';

    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 

    addpath('./../scripts');
    p_table = 'Data/Tables/';
    if CLUSTER,
        p_table  = [cluster_path p_table];
    end
    if perform(org,'clim_from_2ka_PISMfriction_SMB4x'),% {{{

        name ='historic_clim_from_1-2ka_PISMfriction_SMB4x.txt';
        md_end='_-1930_from_2ka_PISM_submit.mat';

        cond =condition_hist1(p_table,name);
        namenew = [p_table 'cond_hist1_' name];
        model_names = strings(size(cond));
        for i =1:size(cond),
            namem=['historic_from_',num2str(cond(i)),md_end];
            model_names(i)=namem;
         end
         T= table(model_names);
         writetable(T,namenew);
    end% }}}
    if perform(org,'clim_from_2ka_Cfriction_mean_SMB4x'),% {{{
        name='historic_clim_from_2ka_Cfriction_mean_SMB4_submit.txt';

        md_end='_-1930_from_2ka_Cfriction_mean_SMB4_submit.mat';

        cond =condition_hist1(p_table,name);
        namenew = [p_table 'cond_hist1_' name];
        model_names = strings(size(cond));
        for i =1:size(cond),
            namem=['historic_from_',num2str(cond(i)),md_end];
            model_names(i)=namem;
         end
         T= table(model_names);
         writetable(T,namenew);


end% }}}`
if perform(org,'clim_from_2ka_Cfriction_nn_SMB4x'),% {{{

    name = 'historic_clim_from_2ka_Cfriction_nn_SMB4_submit.txt';
    md_end ='_-1930_from_2ka_Cfriction_nn_SMB4_submit.mat';
    cond =condition_hist1(p_table,name);
    namenew = [p_table 'cond_hist1_' name];
    model_names = strings(size(cond));
    for i =1:size(cond),
        namem=['historic_from_',num2str(cond(i)),md_end];
        model_names(i)=namem;
     end
     T= table(model_names);
     writetable(T,namenew);


end% }}}
    if perform(org,'from_2ka_2InvCfriction_mean_SMB4x'),% {{{
        name = 'historic_clim_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';

        md_end= '_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat'


        cond =condition_clim(p_table,name);
        namenew = [p_table 'cond_clim_' name];
        model_names = strings(size(cond));
        for i =1:size(cond),
            namem=['historic_clim_from_',num2str(cond(i)),md_end];
            model_names(i)=namem;
         end
         T= table(model_names);
         writetable(T,namenew);

    end% }}}

