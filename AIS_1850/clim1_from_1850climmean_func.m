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
if perform(org,'1850-AtmForcing')% {{{
    md=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');
    % datapath='data_smb;

	m=((1+sin(71*pi/180))*ones(md.mesh.numberofvertices,1)./(1+sin(abs(md.mesh.lat)*pi/180)));
	md.mesh.scale_factor=(1./m).^2;
	
	md.inversion.iscontrol=0;
	md.transient.isthermal=0;
	md.transient.isgroundingline=1;
	md.masstransport.spcthickness=NaN*ones(md.mesh.numberofvertices,1);

	% disp('loading TS and SMB climatology data');
	smbclimnc_lonlat           = [data_smb 'UKESM1-0-LL_clim_ssp585_1995-2014_4km.nc'];
	lat                 = double(ncread(smbclimnc_lonlat,'lat'));
	lon                 = double(ncread(smbclimnc_lonlat,'lon'));
	smb_clim_data       = double(ncread(smbclimnc_lonlat,'smb_clim'));
	% % ts_clim_data        = double(ncread(smbclimnc,'ts_clim'));

	disp('loading TS and SMB anomoly data');
	smbanomnc           = [data_smb 'MAR-UKESM1-0-LL_asmb_1850-1979_histo_regrid_04000m_EXTENDED.nc'];
	smb_anomaly_data    = double(ncread(smbanomnc,'asmb'));
	tsanomnc           = [data_smb 'tas_Ayr_UKESM1-0-LL_historical_r1i1p1f2_1850_2014.nc'];
	ts_anomaly_data     = double(ncread(tsanomnc,'tas'));

	rhoi = md.materials.rho_ice;
	%Create SMB and TS matrix
	t=[1:size(smb_anomaly_data,3)];
	[x_n y_n]=ll2xy(lat(:,1),lon(:,1),-1);
	y_n = x_n;
	smb_clim=InterpFromGridToMesh(x_n,y_n,smb_clim_data',md.mesh.x,md.mesh.y,0);
	% ts_clim=InterpFromGridToMesh(x_n,y_n,ts_clim_data',md.mesh.x,md.mesh.y,0);
	temp_matrix_smb = []; temp_matrix_ts = [];
    smb_clim=interpRacmoSMB_ISMIP6(md,datadir);
	smb_clim=InterpFromGridToMesh(x_n,y_n,smb_clim_data',md.mesh.x,md.mesh.y,0);
    smb_clim    = smb_clim*((31556926/1000)*(1000/rhoi));%m/year
    % ts_clim=interpRacmoTemp_ISMIP6(md,datadir);
	for i = 1:size(smb_anomaly_data,3)
		% disp(i);
		%SMB
		temp_smb        = InterpFromGridToMesh(x_n,y_n,smb_anomaly_data(:,:,i)',md.mesh.x,md.mesh.y,0);
		temp_smb        = temp_smb*((31556926/1000)*(1000/rhoi));%m/year
		temp_smb        = temp_smb+smb_clim;
		temp_matrix_smb = [temp_matrix_smb temp_smb];
		%TS
		% temp_ts         = InterpFromGridToMesh(x_n,y_n,ts_anomaly_data(:,:,i)',md.mesh.x,md.mesh.y,0);
		% % temp_ts         = temp_smb+smb_clim;
		% temp_ts         = temp_ts+ts_clim;
		% temp_matrix_ts  = [temp_matrix_ts temp_ts];
		clear temp_smb; clear temp_ts;
	end

	%Save Data (1995-2100)
	md.smb.mass_balance       = [temp_matrix_smb ; t];
	ukesm_smb_1850_1979           = md.smb.mass_balance;
	% md.miscellaneous.dummy.ts = temp_matrix_ts;
	% miroc_rcp85_ts           = md.miscellaneous.dummy.ts;
	save('./../Data/Atmosphere/ukesm_histo_smb_1850_1979.mat','ukesm_smb_1850_1979');
	% save('Data/Atmosphere/ukesm_histo_clim_ts.mat','miroc_rcp85_ts');

end %}}}
if perform(org,'1980-2014-AtmForcing')% {{{
    md=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');
    % datapath='data_smb;

	m=((1+sin(71*pi/180))*ones(md.mesh.numberofvertices,1)./(1+sin(abs(md.mesh.lat)*pi/180)));
	md.mesh.scale_factor=(1./m).^2;
	
	md.inversion.iscontrol=0;
	md.transient.isthermal=0;
	md.transient.isgroundingline=1;
	md.masstransport.spcthickness=NaN*ones(md.mesh.numberofvertices,1);

	% disp('loading TS and SMB climatology data');
	smbclimnc_lonlat           = [data_smb 'UKESM1-0-LL_clim_ssp585_1995-2014_4km.nc'];
	lat                 = double(ncread(smbclimnc_lonlat,'lat'));
	lon                 = double(ncread(smbclimnc_lonlat,'lon'));
	smb_clim_data       = double(ncread(smbclimnc_lonlat,'smb_clim'));
	% % ts_clim_data        = double(ncread(smbclimnc,'ts_clim'));

	disp('loading TS and SMB anomoly data');
	smbanomnc           = [data_smb 'MAR-UKESM1-0-LL_asmb_1980-2014_histo_regrid_04000m.nc'];
	smb_anomaly_data    = double(ncread(smbanomnc,'asmb'));
	% tsanomnc           = [data_smb 'tas_Ayr_UKESM1-0-LL_historical_r1i1p1f2_1850_2014.nc'];
	% ts_anomaly_data     = double(ncread(tsanomnc,'tas'));

	rhoi = md.materials.rho_ice;
	%Create SMB and TS matrix
	t=[1:size(smb_anomaly_data,3)];
	[x_n y_n]=ll2xy(lat(:,1),lon(:,1),-1);
	y_n = x_n;
	smb_clim=InterpFromGridToMesh(x_n,y_n,smb_clim_data',md.mesh.x,md.mesh.y,0);
	% ts_clim=InterpFromGridToMesh(x_n,y_n,ts_clim_data',md.mesh.x,md.mesh.y,0);
	temp_matrix_smb = []; temp_matrix_ts = [];
    smb_clim=interpRacmoSMB_ISMIP6(md,datadir);
	smb_clim=InterpFromGridToMesh(x_n,y_n,smb_clim_data',md.mesh.x,md.mesh.y,0);
    smb_clim    = smb_clim*((31556926/1000)*(1000/rhoi));%m/year
    % ts_clim=interpRacmoTemp_ISMIP6(md,datadir);
	for i = 1:size(smb_anomaly_data,3)
		% disp(i);
		%SMB
		temp_smb        = InterpFromGridToMesh(x_n,y_n,smb_anomaly_data(:,:,i)',md.mesh.x,md.mesh.y,0);
		temp_smb        = temp_smb*((31556926/1000)*(1000/rhoi));%m/year
		temp_smb        = temp_smb+smb_clim;
		temp_matrix_smb = [temp_matrix_smb temp_smb];
		%TS
		% temp_ts         = InterpFromGridToMesh(x_n,y_n,ts_anomaly_data(:,:,i)',md.mesh.x,md.mesh.y,0);
		% % temp_ts         = temp_smb+smb_clim;
		% temp_ts         = temp_ts+ts_clim;
		% temp_matrix_ts  = [temp_matrix_ts temp_ts];
		clear temp_smb; clear temp_ts;
	end

	%Save Data (1995-2100)
	md.smb.mass_balance       = [temp_matrix_smb ; t];
	ukesm_smb_1980_2014           = md.smb.mass_balance;
	% md.miscellaneous.dummy.ts = temp_matrix_ts;
	% miroc_rcp85_ts           = md.miscellaneous.dummy.ts;
	save('./../Data/Atmosphere/ukesm_histo_1980_2014_smb.mat','ukesm_smb_1980_2014');
	% save('Data/Atmosphere/ukesm_histo_clim_ts.mat','miroc_rcp85_ts');

end %}}}
if perform(org,'1995-2100-AtmForcing')% {{{
    md=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');
    % datapath='data_smb;

	m=((1+sin(71*pi/180))*ones(md.mesh.numberofvertices,1)./(1+sin(abs(md.mesh.lat)*pi/180)));
	md.mesh.scale_factor=(1./m).^2;
	
	md.inversion.iscontrol=0;
	md.transient.isthermal=0;
	md.transient.isgroundingline=1;
	md.masstransport.spcthickness=NaN*ones(md.mesh.numberofvertices,1);

	% disp('loading TS and SMB climatology data');
	smbclimnc_lonlat           = [data_smb_2100 'UKESM1-0-LL_clim_ssp585_1995-2014_2km.nc'];
	lat                 = double(ncread(smbclimnc_lonlat,'lat'));
	lon                 = double(ncread(smbclimnc_lonlat,'lon'));
	smb_clim_data       = double(ncread(smbclimnc_lonlat,'smb_clim'));
	% % ts_clim_data        = double(ncread(smbclimnc,'ts_clim'));

	disp('loading TS and SMB anomoly data');
	smbanomnc           = [data_smb_2100 'UKESM1-0-LL_anomaly_ssp585_1995-2100_2km.nc'];
	smb_anomaly_data    = double(ncread(smbanomnc,'smb_anomaly'));
	% tsanomnc           = [data_smb 'tas_Ayr_UKESM1-0-LL_historical_r1i1p1f2_1850_2014.nc'];
	% ts_anomaly_data     = double(ncread(tsanomnc,'tas'));

	rhoi = md.materials.rho_ice;
	%Create SMB and TS matrix
	t=[1:size(smb_anomaly_data,3)];
	[x_n y_n]=ll2xy(lat(:,1),lon(:,1),-1);
	y_n = x_n;
	smb_clim=InterpFromGridToMesh(x_n,y_n,smb_clim_data',md.mesh.x,md.mesh.y,0);
	% ts_clim=InterpFromGridToMesh(x_n,y_n,ts_clim_data',md.mesh.x,md.mesh.y,0);
	temp_matrix_smb = []; temp_matrix_ts = [];
    smb_clim=interpRacmoSMB_ISMIP6(md,datadir);
	smb_clim=InterpFromGridToMesh(x_n,y_n,smb_clim_data',md.mesh.x,md.mesh.y,0);
    smb_clim    = smb_clim*((31556926/1000)*(1000/rhoi));%m/year
    %% ts_clim=interpRacmoTemp_ISMIP6(md,datadir);
	for i = 1:size(smb_anomaly_data,3)
		% disp(i);
		%SMB
		temp_smb        = InterpFromGridToMesh(x_n,y_n,smb_anomaly_data(:,:,i)',md.mesh.x,md.mesh.y,0);
		temp_smb        = temp_smb*((31556926/1000)*(1000/rhoi));%m/year
		temp_smb        = temp_smb+smb_clim;
		temp_matrix_smb = [temp_matrix_smb temp_smb];
		%TS
		% temp_ts         = InterpFromGridToMesh(x_n,y_n,ts_anomaly_data(:,:,i)',md.mesh.x,md.mesh.y,0);
		% % temp_ts         = temp_smb+smb_clim;
		% temp_ts         = temp_ts+ts_clim;
		% temp_matrix_ts  = [temp_matrix_ts temp_ts];
		clear temp_smb; clear temp_ts;
	end

	%Save Data (1995-2100)
	md.smb.mass_balance       = [temp_matrix_smb ; t];
	ukesm_smb_1995_2100           = md.smb.mass_balance;
	% md.miscellaneous.dummy.ts = temp_matrix_ts;
	% miroc_rcp85_ts           = md.miscellaneous.dummy.ts;
	save('./../Data/Atmosphere/ukesm_1995_2100_smb.mat','ukesm_smb_1995_2100');
	% save('Data/Atmosphere/ukesm_histo_clim_ts.mat','miroc_rcp85_ts');

end %}}}
if perform(org,'1931-2030-AtmForcing')% {{{
    load './../Data/Atmosphere/ukesm_histo_smb_1850_1979.mat';
    load './../Data/Atmosphere/ukesm_histo_1980_2014_smb.mat';
    load './../Data/Atmosphere/ukesm_1995_2100_smb.mat';
    temp_matrix_smb = [];
	temp_matrix_smb = [temp_matrix_smb ukesm_smb_1850_1979(:,82:end)]; %1931 - 1979
	temp_matrix_smb = [temp_matrix_smb ukesm_smb_1980_2014]; %1980-2014 % MAR
	temp_matrix_smb = [temp_matrix_smb ukesm_smb_1995_2100(:,21:36)]; %2015-2030 % MAR
    ukesm_smb_1931_2030 = temp_matrix_smb;
	save('./../Data/Atmosphere/ukesm_1932_2030_smb.mat','ukesm_smb_1931_2030');

end %}}}
if perform(org,'1931-2030-OceanForcing')% {{{
    load './../Data/Ocean/ukesm_histo_smb_1850_1979.mat';
    % load './../Data/Atmosphere/ukesm_histo_1980_2014_smb.mat';
    % load './../Data/Atmosphere/ukesm_1995_2100_smb.mat';
    % temp_matrix_smb = [];
	% temp_matrix_smb = [temp_matrix_smb ukesm_smb_1850_1979(:,82:end)]; %1931 - 1979
	% temp_matrix_smb = [temp_matrix_smb ukesm_smb_1980_2014]; %1980-2014 % MAR
	% temp_matrix_smb = [temp_matrix_smb ukesm_smb_1995_2100(:,21:36)]; %2015-2030 % MAR
    % ukesm_smb_1931_2030 = temp_matrix_smb;
	% save('./../Data/Atmosphere/ukesm_1932_2030_smb.mat','ukesm_smb_1931_2030');

end %}}}
    % submit and load hist1 run starting frrom all clim forifnc 
    if perform(org,'-1930_from_2ka_Cfriction_nn_SMB4_submit'),% {{{

        for i=1:1
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat']
            md_in_path = ['Models/' modelname];
            md = model_hist_clim_1_2ka_exp(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end

    end% }}}
    if perform(org,'-1930_from_2ka_Cfriction_mean_SMB4_submit'),% {{{

        for i=1:1
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            md_in_path = ['Models/' modelname];
            md = model_hist_clim_1_2ka_exp(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end

    end% }}}
    if perform(org,'-1930_from_2ka_Cfriction_nn_SMB4_load'),% {{{

        for i=1:21
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist1_load(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end

    end% }}}
    if perform(org,'-1930_from_2ka_Cfriction_mean_SMB4_load'),% {{{

        for i=10:21
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist1_load(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end

    end% }}}
    % submitted only appropiate run
    if perform(org,'_clim-1930_from_2ka_2INVCfriction_mean'),% {{{
        name = 'historic_clim_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';
        namenew = [p_table 'cond_clim_' name];

        T = readtable(namenew, 'Delimiter' , ',');
        for i =1:size(T,1)

            md_in_path = ['Models/' T.model_names{i}];
            md = model_continue_hist1(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end
    end% }}}
    % submit here from all clim runs, did not do analaysis
    if perform(org,'_clim-1930_from_2ka_2INVCfriction_mean_oceanPIG95percentile'),% {{{
        for i =1:21

            modelname  = ['historic_clim_oceanPIG95percentile_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
            md_in_path = ['Models/' modelname];
            md = model_continue_hist1_oceanPIG95percentile(md_in_path);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end
    end% }}}
    % submit and load hist1 run starting fram apporopiate clim 1850 forcingi
