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

    % crecate climate forcing ATM
if perform(org,'1850-repeated-AtmForcing')% {{{                                                                                                                                                                                               
    load './../Data/Atmosphere/ukesm_histo_smb_1850_1979.mat';
    array_size = 250;
    % Set the seed value
    seed_value = 123; % You can choose any integer value
 
    % Set the seed
    rng(seed_value);
 
    % Generate random integers between 1 and 50
    random_integers = randi([1, 50], 1, array_size);
    temp_matrix_smb = [];
    temp_matrix_smb = [temp_matrix_smb ukesm_smb_1850_1979(:,random_integers)]; %2031-2100 % MAR
    ukesm_smb_1850_repeat = temp_matrix_smb;
    save('./../Data/Atmosphere/ukesm_1850_repeat_smb.mat','ukesm_smb_1850_repeat');
 
end %}}}
if perform(org,'2001-2100-AtmForcing')% {{{
    load './../Data/Atmosphere/ukesm_1995_2100_smb.mat';
    temp_matrix_smb = [];
    temp_matrix_smb = [temp_matrix_smb ukesm_smb_1995_2100(:,7:end)]; %2000-2100 % MAR
    ukesm_smb_2001_2100 = temp_matrix_smb;
	save('./../Data/Atmosphere/ukesm_2001_2100_smb.mat','ukesm_smb_2001_2100');

end %}}}
    % crecate climate forcing ocean
if perform(org,'2001-2100-OceanForcing')% {{{
    load './../Data/Ocean/ukesm_ssp585_tf.mat';
    sz = size(ukesm1_1995_2100_tf);
    depths = sz(3);
    tf = cell(1,1,depths);
    t =1:100;
    for i=1:depths   %Iterate over depths
        d_proj_time_cell =ukesm1_1995_2100_tf(:,:,i);
        proj_snip = d_proj_time_cell{1}(:,7:end);
        snip =[];
        snip = [snip proj_snip];
        snip(end,:) = t;
        tf(:,:,i)={snip};
    end

    ukesm1_2001_2100_tf = tf;
    save('./../Data/Ocean/ukesm_2001_2100_tf.mat','ukesm1_2001_2100_tf','-v7.3');

end %}}}
if perform(org,'1850-repeated-OceanForcing')% {{{                                                                                                                                                                                             
    load './../Data/Ocean/ukesm_histo_tf.mat';
    sz = size(ukesm1_1850_1994_tf);
    depths = sz(3);
    tf = cell(1,1,depths);
    t =1:250;
 
    array_size = 250;%same as atmosphere forcing
    % Set the seed value
    seed_value = 123; % You can choose any integer value
    % Set the seed
    rng(seed_value);
    % Generate random integers between 1 and 50
    random_integers = randi([1, 50], 1, array_size);
 
    for i=1:depths   %Iterate over depths
        d_hist_time_cell =ukesm1_1850_1994_tf(:,:,i);
        hist_snip = d_hist_time_cell{1}(:,random_integers);
        snip =[];
        snip = [snip hist_snip];
        snip(end,:) = t;
        tf(:,:,i)={snip};
    end
 
    ukesm1_1850_repeated_tf = tf;
    save('./../Data/Ocean/ukesm_1850_repeated_tf.mat','ukesm1_1850_repeated_tf','-v7.3');
 
end %}}}
    %19-24specific chosen i and t
    %17-22
    if perform(org,'THW_best'),% {{{

        j = 10;
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=1;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        for i = 1:numel(inds),
            ind = inds(i);
            time =(ind-1)*100;
            
            modelname  = ['hist2_hist1_timeyear_' num2str(time) '_historic_clim_from_' num2str(j) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
            disp(modelname);
            md_in_path = ['Models/' modelname];
            md =model_continue_proj2100(md_in_path);

            disp(md.miscellaneous.name);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end
        



    end% }}}
    if perform(org,'PIG_TOTTEN_MOSCOW_best'),% {{{
        j = 10;
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=1;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        for i = 1:numel(inds),
            ind = inds(i);
            time =(ind-1)*100;
            
            modelname  = ['hist2_hist1_timeyear_' num2str(time) '_historic_clim_from_' num2str(j) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25'];
            md_in_path = ['Models/' modelname];
            md =model_continue_proj2100(md_in_path);

            disp(md.miscellaneous.name);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end



    end% }}}
