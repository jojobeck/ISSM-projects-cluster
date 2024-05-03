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
    p_table = 'Data/Tables/';

    % crecate climate forcing

if perform(org,'1850-repeated-AtmForcingi_first125')% {{{                                                                                                                                                                                               
    load './../Data/Atmosphere/ukesm_histo_smb_1850_1979.mat';
    array_size = 250;
    % Set the seed value
    seed_value = 123; % You can choose any integer value
 
    % Set the seed
    rng(seed_value);
 
    % Generate random integers between 1 and 50
    random_integers = randi([1, 50], 1, array_size);
    temp_matrix_smb = [];
    temp_matrix_smb = [temp_matrix_smb ukesm_smb_1850_1979(:, random_integers(1:125))]; %2031-2100 % MAR
    ukesm_smb_1850_repeat = temp_matrix_smb;
    ukesm_smb_1850_repeat(end,:) = 1:125;
    save('./../Data/Atmosphere/ukesm_1850_repeat_smb_first125.mat','ukesm_smb_1850_repeat');
 
end %}}}
if perform(org,'1850-repeated-OceanForcing_first125')% {{{                                                                                                                                                                                             
    load './../Data/Ocean/ukesm_histo_tf.mat';
    sz = size(ukesm1_1850_1994_tf);
    depths = sz(3);
    tf = cell(1,1,depths);
    t =1:125;
 
    array_size = 250;%same as atmosphere forcing
    % Set the seed value
    seed_value = 123; % You can choose any integer value
    % Set the seed
    rng(seed_value);
    % Generate random integers between 1 and 50
    random_integers = randi([1, 50], 1, array_size);
 
    for i=1:depths   %Iterate over depths
        d_hist_time_cell =ukesm1_1850_1994_tf(:,:,i);
        hist_snip = d_hist_time_cell{1}(:,random_integers(1:125));
        snip =[];
        snip = [snip hist_snip];
        snip(end,:) = t;
        tf(:,:,i)={snip};
    end
 
    ukesm1_1850_repeated_tf = tf;
    save('./../Data/Ocean/ukesm_1850_repeated_tf_first125.mat','ukesm1_1850_repeated_tf','-v7.3');
 
end %}}}
    % submit and load hist1 run starting frrom all clim forifnc 
if perform(org,'1850-repeated-AtmForcingi_second125')% {{{                                                                                                                                                                                               
    load './../Data/Atmosphere/ukesm_histo_smb_1850_1979.mat';
    array_size = 250;
    % Set the seed value
    seed_value = 123; % You can choose any integer value
 
    % Set the seed
    rng(seed_value);
 
    % Generate random integers between 1 and 50
    random_integers = randi([1, 50], 1, array_size);
    temp_matrix_smb = [];
    temp_matrix_smb = [temp_matrix_smb ukesm_smb_1850_1979(:, random_integers(126:end))]; %2031-2100 % MAR
    ukesm_smb_1850_repeat = temp_matrix_smb;
    ukesm_smb_1850_repeat(end,:) = 1:125;
    save('./../Data/Atmosphere/ukesm_1850_repeat_smb_second125.mat','ukesm_smb_1850_repeat');
 
end %}}}
if perform(org,'1850-repeated-OceanForcing_second125')% {{{                                                                                                                                                                                             
    load './../Data/Ocean/ukesm_histo_tf.mat';
    sz = size(ukesm1_1850_1994_tf);
    depths = sz(3);
    tf = cell(1,1,depths);
    t =1:125;
 
    array_size = 250;%same as atmosphere forcing
    % Set the seed value
    seed_value = 123; % You can choose any integer value
    % Set the seed
    rng(seed_value);
    % Generate random integers between 1 and 50
    random_integers = randi([1, 50], 1, array_size);
 
    for i=1:depths   %Iterate over depths
        d_hist_time_cell =ukesm1_1850_1994_tf(:,:,i);
        hist_snip = d_hist_time_cell{1}(:,random_integers(126:end));
        snip =[];
        snip = [snip hist_snip];
        snip(end,:) = t;
        tf(:,:,i)={snip};
    end
 
    ukesm1_1850_repeated_tf = tf;
    save('./../Data/Ocean/ukesm_1850_repeated_tf_second125.mat','ukesm1_1850_repeated_tf','-v7.3');
 
end %}}}
    if perform(org,'THW_best'),% {{{


        i = 10;
        modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=1;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_repeat1850_specifictimes(md_in,ind);
            disp(md.miscellaneous.name);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end





    end% }}}
    if perform(org,'PIG_TOTTEN_MOSCOW_best'),% {{{
        i = 10;
        modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25'];
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=1;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_repeat1850_specifictimes(md_in,ind);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end



    end% }}}
% have to split up foriing i to big in GB
    if perform(org,'THW_best_continue'),% {{{


        modelname  = ['repeat1850_timeyear_0_historic_clim_from_10_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
        md_in_path = ['Models/' modelname];
        md_in =loadmodel(md_in_path);
        md = model_continue_repeat1850_cont2_specifictimes(md_in);
        disp(md.miscellaneous.name);
        md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
        if loadonly
            % savemodel
            save_misc_name(md);
        end





    end% }}}
    if perform(org,'PIG_TOTTEN_MOSCOW_best_continue'),% {{{
        modelname  = ['repeat1850_timeyear_0_historic_clim_from_10_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25'];
        md_in_path = ['Models/' modelname];
        md_in =loadmodel(md_in_path);
        % specific timming point form clim experiment
        md = model_continue_repeat1850_cont2_specifictimes(md_in);
        md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
        disp(md.miscellaneous.name);
        if loadonly
            % savemodel
            save_misc_name(md);
        end



    end% }}}
