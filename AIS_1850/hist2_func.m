
function md=run_func(steps,loadonly)
    if ~exist('loadonly','var')
     % if 1, save figures
      loadonly=1;
    end

    numberOfWorkers = 48;
    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 

    addpath('./../scripts');
    p_table = 'Data/Tables/';
    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday'),% {{{

        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end

        end
    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{
        name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly,
                % savemodel
                save_misc_name(md);
            end
        end



end% }}}`
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x'),% {{{

    name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';

    namenew = [p_table 'cond_hist1_' name];
    T = readtable(namenew, 'Delimiter' , ',');
    for i =1:size(T,1)

        md_in_path = ['Models/' T.model_names{i}];
        md = model_continue_hist2(md_in_path);
        md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
        if loadonly
            % savemodel
            save_misc_name(md);
        end
    end



end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{
        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end


    end% }}}
