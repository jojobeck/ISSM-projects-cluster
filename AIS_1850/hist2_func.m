function md=run_func(steps,loadonly)
    if ~exist('loadonly','var')
     % if 1, save figures
      loadonly=1;
    end

    numberOfWorkers = 48;
    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 

    addpath('./../scripts');
    p_table = 'Data/Tables/';
    %1-4
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
    % for now iam taking all his1 runs to see if there is a movements in hist 2
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{

        for i=1:21
            modelname  = ['hist1_historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end


end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x'),% {{{

    for i=1:21
        modelname  = ['hist1_historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat']
        md_in_path = ['Models/' modelname];
        md = model_continue_hist2(md_in_path);
        md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
        disp(md.miscellaneous.name);
        if loadonly
            % savemodel
            save_misc_name(md);
        end
    end



end% }}}
    % for now iam taking all his1 runs to see if there is a movements in hist 2
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{
        name = 'historic_clim_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';
        namenew = [p_table 'cond_clim_' name];

        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path=['Models/' 'hist1_' T.model_names{i}];
            md = model_continue_hist2(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end


    end% }}}
    %taking all runs for different p of cfrcition
    %5-8
    if perform(org,'_1930-2030_2INVCfriction_mean_SMB4_submit_c0.75'),% {{{
        for i=10:41
            modelname  = ['hist1_historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.75']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end



    end% }}}
    if perform(org,'_1930-2030_2INVCfriction_mean_SMB4_submit_c0.5'),% {{{
        for i=10:41
            modelname  = ['hist1_historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0-2ka_Cfriction_mean_SMB4x_cfriction0.5']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end



    end% }}}
    if perform(org,'_1930-2030_2INVCfriction_mean_SMB4_submit_c0.25'),% {{{
        for i=10:41
            modelname  = ['hist1_historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end



    end% }}}
% taking 95 percentile pig from all hist 1 runs
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_oceanPIG95percentile_true'),% {{{
        for i =1:21

            modelname  = ['hist1_historic_clim_oceanPIG95percentile_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2_oceanPIG95percentile(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end


    end% }}}
    %9-12
%test 95 percentile but hist 1 was still on meadian !!!
    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday_ocean95percentile'),% {{{

        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2_ocean95percentile(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end

        end
    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_ocean95percentile'),% {{{
        name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2_ocean95percentile(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly,
                % savemodel
                save_misc_name(md);
            end
        end



end% }}}`
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x_ocean95percentile'),% {{{

    name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';

    namenew = [p_table 'cond_hist1_' name];
    T = readtable(namenew, 'Delimiter' , ',');
    for i =1:size(T,1)

        md_in_path = ['Models/' T.model_names{i}];
        md = model_continue_hist2_ocean95percentile(md_in_path);
        md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
        if loadonly
            % savemodel
            save_misc_name(md);
        end
    end



end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_ocean95percentile'),% {{{
        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2_ocean95percentile(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end


    end% }}}


    %13-16
    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday_oceanPIG95percentile'),% {{{

        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2_oceanPIG95percentile(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end

        end
    end% }}}
    if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_oceanPIG95percentile'),% {{{
        name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2_oceanPIG95percentile(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly,
                % savemodel
                save_misc_name(md);
            end
        end



end% }}}`
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x_oceanPIG95percentile'),% {{{

    name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';

    namenew = [p_table 'cond_hist1_' name];
    T = readtable(namenew, 'Delimiter' , ',');
    for i =1:size(T,1)

        md_in_path = ['Models/' T.model_names{i}];
        md = model_continue_hist2_oceanPIG95percentile(md_in_path);
        md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
        if loadonly
            % savemodel
            save_misc_name(md);
        end
    end



end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x_oceanPIG95percentile'),% {{{
        name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';

        namenew = [p_table 'cond_hist1_' name];
        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist2_oceanPIG95percentile(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end


    end% }}}
%specific times
    %17-22
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.75_specific'),% {{{

    end% }}}
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.5_specific'),% {{{


    end% }}}
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.25_specific'),% {{{

        i = 22;
        % specific timming point form clim experiment
        time_start=100;
        time_endyears=500;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        for i = 1:numel(inds),
            ind = inds(i);
            time =(ind-1)*100;
            
            modelname  = ['hist1_timyear_' num2str(time) 'historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path,ind);

            disp(md.miscellaneous.name);
            % md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end
        
        i = 41;
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=300;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        for i = 1:numel(inds),
            ind = inds(i);
            time =(ind-1)*100;
            
            modelname  = ['hist1_timyear_' num2str(time) 'historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path,ind);

            disp(md.miscellaneous.name);
            % md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end
        %%%%%%%%%%%%%%%%%%%%
        i = 10;
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=500;
        inds =time_indices_historic_clim(time_start,time_endyears,10);

        for i = 1:numel(inds),
            ind = inds(i);
            time =(ind-1)*100;
            
            modelname  = ['hist1_timyear_' num2str(time) 'historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path,ind);

            disp(md.miscellaneous.name);
            % md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end




    end% }}}
    if perform(org,'-1930_mean_SMB4_submit_c0.75_specific'),% {{{
        for i=10:41
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.75']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist1(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end



    end% }}}
    if perform(org,'-1930_mean_SMB4_submit_c0.5_specific'),% {{{
        i = 41;
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=100;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        for i = 1:numel(inds),
            ind = inds(i);
            time =(ind-1)*100;
            
            modelname  = ['hist1_timyear_' num2str(time) 'historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path,ind);

            disp(md.miscellaneous.name);
            % md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end




    end% }}}
    if perform(org,'-1930_mean_SMB4_submit_c0.25_specific'),% {{{
        i = 41;
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=100;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        for i = 1:numel(inds),
            ind = inds(i);
            time =(ind-1)*100;
            
            modelname  = ['hist1_timyear_' num2str(time) 'historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
            md_in_path = ['Models/' modelname];
            md = model_continue_hist2(md_in_path,ind);

            disp(md.miscellaneous.name);
            % md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end



    end% }}}
