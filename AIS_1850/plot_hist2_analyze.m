function name=plot_hist2_analyze(steps,save_fig)

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

    if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday'),% {{{
        figname_in='PISM_1932-2030_from2ka';

        name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
        parts = strsplit(name, 'from_');
        parts2 =strsplit(parts{2},'_SMB4x.txt');
        namo = parts2{1};


        name_table = ['./Data/Tables/','orderd_experiments_weighted_within_exptype_' namo '.txt'];
        T_order = readtable(name_table, 'Delimiter' , ',');
        name_table = ['./Data/Tables/','time_min_distance_hist2_runs' namo '.txt'];
        T_i = readtable(name_table, 'Delimiter' , ',');
        i_end=size(T_order,1);
        for i=1:i_end 
            runName=['hist2_' T_order.model_names{i}];
            model_pth = ['Models/' runName];

            md_hist = loadmodel(model_pth);
            figname =[figname_in '_' num2str(i)];


            %TODO add figname change

            j=T_order.indices(i);
            ii = find(T_i.model_names==j);
            %get the best inidces for hist and p.d. gl.
            times_irun=zeros(1,6);
            
            times_irun(1)=T_i(ii,2).Variables;
            times_irun(2)=T_i(ii,3).Variables+59;

            times_irun(3)=T_i(ii,4).Variables+79;
            times_irun(4)=T_i(ii,5).Variables+79;
            times_irun(5)=T_i(ii,6).Variables+79;
            times_irun(6)=T_i(ii,7).Variables+79;

            %TODO: adhjust plooting MAKE fucntion above
            plot_4glaciers_hist2eval(md_hist,times_irun,figname,save_fig);
        end
    end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{

    md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
    figname='Cmean_1850_1930_from2ka';
    md_end='_-1930_from_2ka_Cfriction_mean_SMB4_submit.mat';

    plot_4glaciers(md_in,md_end,figname,save_fig)


end% }}}`
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x'),% {{{

    md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
    md_end ='_-1930_from_2ka_Cfriction_nn_SMB4_submit.mat';
    figname='Cnn_1850_1930_from2ka';
    plot_4glaciers(md_in,md_end,figname,save_fig)


end% }}}
    if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');

        md_end = '_-1930_from_2ka_2INVCfriction_mean_SMB4_submit.mat';

        figname='2Inv_1850_1930_from2ka';

    plot_4glaciers(md_in,md_end,figname,save_fig)

    end% }}}
