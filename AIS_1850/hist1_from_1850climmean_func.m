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
    if perform(org,'-1930_from_2ka_PISM_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md=md_in;
        sz = size(md.results.TransientSolution);
        % for i =3:sz(2)
        % for i =1:sz(2),
        for i =5:sz(2),
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep).string];
           
            md.initialization.watercolumn = md_in.results.TransientSolution(i).Watercolumn;

            pos = md.initialization.watercolumn <0;

            md.initialization.watercolumn(pos)=0;
            pos = md.initialization.watercolumn >2;
            md.initialization.watercolumn(pos)=2;
            md.initialization.pressure= md_in.results.TransientSolution(i).Pressure;



            md.inversion.iscontrol=0;
            md.transient.isthermal=0;
            md.transient.isgroundingline=1;
            md.masstransport.spcthickness=NaN*ones(md.mesh.numberofvertices,1);

            %Load forcing data
            load './../Data/Atmosphere/ukesm_histo_smb.mat';
            load './../Data/Ocean/ukesm_histo_tf.mat';
            load './../Data/Ocean/deltat_median.mat';
            load './../Data/Ocean/gamma0_median.mat';
            load './../Data/Ocean/basinid.mat';
            load './../Data/Ocean/tf_depths.mat';

            %Set SMB Forcing Parameters
            miroc_rcp85_smb(1:end-1,:) = miroc_rcp85_smb(1:end-1,:);
            md.smb.mass_balance = miroc_rcp85_smb; %already in m/year ice

            %Set ISMIP6 basal melt rate parameters
            delta_t                     = deltat_median;
            md.basalforcings            = basalforcingsismip6(md.basalforcings);
            md.basalforcings.basin_id   = basinid;
            md.basalforcings.num_basins = length(unique(basinid));
            md.basalforcings.delta_t    = delta_t;
            md.basalforcings.tf_depths  = tf_depths;
            md.basalforcings.gamma_0    = gamma0_median;
            md.basalforcings.tf         = obs_clim_tf;
            md.basalforcings.islocal = 0;

            %Model specifications
            md.outputdefinition.definitions={};
            md.timestepping.interp_forcing=0;
            md.timestepping.start_time=1;
            md.timestepping.final_time=81;
            md.timestepping.time_step=1/24;
            md.settings.output_frequency=24*25;
            md.transient.requested_outputs={'default'};

            %Set melt / friction interpolation schemes
            md.groundingline.migration = 'SubelementMigration';
            md.groundingline.friction_interpolation='SubelementFriction1';
            md.groundingline.melt_interpolation='SubelementMelt1';

            %Solve
            md.verbose=verbose('solution',true,'module',true,'convergence',true);
            clustername = 'gadi';
            cluster = set_cluster(clustername);
            md.cluster=cluster;
            md.settings.waitonlock=0;
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
           
        end

    end% }}}
    if perform(org,'-1930_from_2ka_Cfriction_nn_SMB4_submit'),% {{{

        for i=1:21
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat']
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
    if perform(org,'-1930_from_2ka_Cfriction_mean_SMB4_submit'),% {{{

        for i=1:1
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat']
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
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.75'),% {{{
        for i=10:41
            modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.75']
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
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.5'),% {{{
        for i=10:41
            modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0-2ka_Cfriction_mean_SMB4x_cfriction0.5']
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
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.25'),% {{{
        for i=10:41
            modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25']
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
    if perform(org,'-1930_mean_SMB4_submit_c0.75'),% {{{
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
    if perform(org,'-1930_mean_SMB4_submit_c0.5'),% {{{
        for i=10:41
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.5']
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
    if perform(org,'-1930_mean_SMB4_submit_c0.25'),% {{{
        for i=10:41
            modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25']
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
    %19-24specific chosen i and t
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.75_specific'),% {{{
        % specific staring point
        i = 28;
        modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.75'];
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=300;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind)
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end

        i = 41;
        modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.75'];
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=500;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind)
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end


        i = 10;
        modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.75'];
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=500;
        time_endyears=900;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind)
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end


    end% }}}
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.5_specific'),% {{{



    end% }}}
    if perform(org,'-1930_2INVCfriction_mean_SMB4_submit_c0.25_specific'),% {{{

        i = 22;
        modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=100;
        time_endyears=500;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind);

            disp(md.miscellaneous.name);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end
        
        i = 41;
        modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=300;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind);

            disp(md.miscellaneous.name);
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end

% i = 10;
% modelname  = ['historic_clim_from_' num2str(i) '_RedoforTHW_nobasal_melt_nonlocal_0_2ka_Cfriction_mean_SMB4x_cfriction0.25'];
% md_in_path = ['Models/' modelname];
% specific timming point form clim experiment
% time_start=1;
% time_endyears=500;
% inds =time_indices_historic_clim(time_start,time_endyears,10);
% md_in =loadmodel(md_in_path);
% for i = 1:numel(inds),
% ind = inds(i);
% md = model_continue_hist1_specifictimes(md_in,ind);
% disp(md.miscellaneous.name);
% md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
% if loadonly
% savemodel
% save_misc_name(md);
% end
% end





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
        modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.5']
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=100;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind)
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end




    end% }}}
    if perform(org,'-1930_mean_SMB4_submit_c0.25_specific'),% {{{
        i = 41;
        modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25']
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=900;
        time_endyears=1000;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind)
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end

        i = 10;
        modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25']
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=1
        time_endyears=100;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind)
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end

        i = 23;
        modelname  = ['historic_clim_from_' num2str(i) '_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x_0_2k_cfriction0.25']
        md_in_path = ['Models/' modelname];
        % specific timming point form clim experiment
        time_start=1;
        time_endyears=100;
        inds =time_indices_historic_clim(time_start,time_endyears,10);
        md_in =loadmodel(md_in_path);
        for i = 1:numel(inds),
            ind = inds(i);
            md = model_continue_hist1_specifictimes(md_in,ind)
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
            disp(md.miscellaneous.name);
            if loadonly
                % savemodel
                save_misc_name(md);
            end
        end



    end% }}}
