function md =model_hist_clim_exp(md_in,loadonly)

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
        md.miscellaneous.name=['historic_clim_from_',num2str(i),'_',md_in.miscellaneous.name];
        spl_name = split(md_in.miscellaneous.name,'PISM');
        if size(spl_name,1)>1,
            disp('PISM hydrology');
       
            md.initialization.watercolumn = md_in.results.TransientSolution(i).Watercolumn;

            pos = md.initialization.watercolumn <0;

            md.initialization.watercolumn(pos)=0;
            pos = md.initialization.watercolumn >2;
            md.initialization.watercolumn(pos)=2;
            md.initialization.pressure= md_in.results.TransientSolution(i).Pressure;
        end
       
        md.inversion.iscontrol=0;
        md.transient.isthermal=0;
        md.transient.isgroundingline=1;
        md.masstransport.spcthickness=NaN*ones(md.mesh.numberofvertices,1);

        %Load forcing data
        load './../Data/Atmosphere/ukesm_histo_clim_smb.mat';
        load './../Data/Ocean/ukesm_histo_clim_tf.mat';
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
        md.timestepping.final_time=1000;
        md.timestepping.time_step=1/24;
        md.settings.output_frequency=24*10;
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
