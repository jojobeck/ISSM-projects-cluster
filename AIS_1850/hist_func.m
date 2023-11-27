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
    datadir= '/Users/jbec0008/SAEF/datasets/';
    data_smb='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/preprocess/SMB_JOHANNA/';
    data_smb_2100='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/AtmosphericForcing/UKESM1-0-LL/Regridded_2km/';
    data_2km_xy='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/AtmosphericForcing/noresm1-m_rcp8.5/';
    data_ocean='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/Ocean/';
    data_tmp_ocean = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Ocean/';
    data_tmp_smb = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Atmosphere/';
    % loadonly=1;
    % InterpFromMeshToMesh2d

    % clim runs 10-12
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

    if perform(org,'-1930_from_2ka_Cfriction_nn_SMB4_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
        md=md_in;
        sz = size(md.results.TransientSolution);
        for i =4:4,
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep).string];
           
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
           
            if loadonly;
                % savemodel
                pvel = './Models';
                save_p= fullfile(pvel, md.miscellaneous.name);
                save(save_p,'md','-v7.3');
            end
        end


    end% }}}
    if perform(org,'-1930_from_2ka_Cfriction_nn_SMB4_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');
        md=md_in;
        sz = size(md.results.TransientSolution);
        for i =1:sz(2),
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep-1).string];
            %Solve
            md.verbose=verbose('solution',true,'module',true,'convergence',true);
            clustername = 'gadi';
            cluster = set_cluster(clustername);
            md.cluster=cluster;
            md.settings.waitonlock=0;
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
           
            if loadonly;
                % savemodel
                % pvel = '/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models';
                pvel = './Models';
                save_p= fullfile(pvel, md.miscellaneous.name);
                save(save_p,'md','-v7.3');
            end
        end


    end% }}}
    if perform(org,'-1930_from_1ka_2INVCfriction_mean_SMB4_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md=md_in;

        sz = size(md.results.TransientSolution);
        for i =11:sz(2),
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep).string];
           
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
           
            if loadonly;
                % savemodel
                pvel = '/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models';
                pvel = './Models';
                save_p= fullfile(pvel, md.miscellaneous.name);
                save(save_p,'md','-v7.3');
            end
        end


    end% }}}
    if perform(org,'-1930_from_1ka_2INVCfriction_mean_SMB4_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1ka_Cfriction_mean_SMB4x.mat');
        md=md_in;
        sz = size(md.results.TransientSolution);

        for i =1:sz(2),
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep-1).string];
            md.verbose=verbose('solution',true,'module',true,'convergence',true);
            clustername = 'gadi';
            cluster = set_cluster(clustername);
            md.cluster=cluster;
            md.settings.waitonlock=0;
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
           
           
            if loadonly;
                % savemodel
                pvel = '/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models';
                % pvel = './Models';
                save_p= fullfile(pvel, md.miscellaneous.name);
                save(save_p,'md','-v7.3');
            end
        end


    end% }}}
    if perform(org,'-1930_from_2ka_Cfriction_mean_SMB4_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md=md_in;
        sz = size(md.results.TransientSolution);
        for i =1:1

            base = md_in.results.TransientSolution(i).Base;
            thickness = md.results.TransientSolution(i).Thickness;
            surface = md.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep).string];
           
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
    if perform(org,'-1930_from_2ka_Cfriction_mean_SMB4_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md=md_in;
        sz = size(md.results.TransientSolution);
        % for i =3:sz(2)
        for i =1:sz(2),
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep-1).string];
           
            md.inversion.iscontrol=0;
            md.transient.isthermal=0;
            md.transient.isgroundingline=1;
            md.masstransport.spcthickness=NaN*ones(md.mesh.numberofvertices,1);

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
           
            if loadonly;
                % savemodel
                pvel = './Models';
                save_p= fullfile(pvel, md.miscellaneous.name);
                save(save_p,'md','-v7.3');
            end
        end

    end% }}}
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
    if perform(org,'-1930_from_2ka_PISM_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
        md=md_in;
        sz = size(md.results.TransientSolution);
        % for i =3:sz(2)
        for i =1:sz(2),
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep-1).string];
           
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
           
            if loadonly;
                % savemodel
                pvel = './Models';
                save_p= fullfile(pvel, md.miscellaneous.name);
                save(save_p,'md','-v7.3');
            end
        end

    end% }}}
    if perform(org,'-1930_from_2ka_2INVCfriction_mean_SMB4_submit'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md=md_in;

        sz = size(md.results.TransientSolution);
        for i =11:sz(2),
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep).string];
           
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
           
            if loadonly;
                % savemodel
% pvel = '/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models';
                pvel = './Models';
                save_p= fullfile(pvel, md.miscellaneous.name);
                save(save_p,'md','-v7.3');
            end
        end


    end% }}}
    if perform(org,'-1930_from_2ka_2INVCfriction_mean_SMB4_load'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');
        md=md_in;
        sz = size(md.results.TransientSolution);

        for i =1:sz(2),
            base = md_in.results.TransientSolution(i).Base;
            thickness = md_in.results.TransientSolution(i).Thickness;
            surface = md_in.results.TransientSolution(i).Surface;
            md.geometry.thickness = thickness;
            md.geometry.surface = surface;
            md.geometry.base = base;
            md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
            md.miscellaneous.name=['historic_from_',num2str(i),'_',org.steps(org.currentstep-1).string];
            md.verbose=verbose('solution',true,'module',true,'convergence',true);
            clustername = 'gadi';
            cluster = set_cluster(clustername);
            md.cluster=cluster;
            md.settings.waitonlock=0;
            md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
           
           
            if loadonly;
                % savemodel
                pvel = './Models';
                save_p= fullfile(pvel, md.miscellaneous.name);
                save(save_p,'md','-v7.3');
            end
        end


    end% }}}
