function md = model_continue_hist2(md_in_path)
    md_in = loadmodel(md_in_path);
    md = md_in;

    base = md_in.results.TransientSolution(end).Base;
    thickness = md_in.results.TransientSolution(end).Thickness;
    surface = md_in.results.TransientSolution(end).Surface;
    md.geometry.thickness = thickness;
    md.geometry.surface = surface;
    md.geometry.base = base;
    md.mask.ocean_levelset= md_in.results.TransientSolution(end).MaskOceanLevelset;
    md.miscellaneous.name=['hist2_',md.miscellaneous.name];
    spl_name = split(md_in_path,'PISM');
    if size(spl_name,1)>1,
        disp('PISM hydrology');
   
        md.initialization.watercolumn = md_in.results.TransientSolution(end).Watercolumn;

        pos = md.initialization.watercolumn <0;

        md.initialization.watercolumn(pos)=0;
        pos = md.initialization.watercolumn >2;
        md.initialization.watercolumn(pos)=2;
        md.initialization.pressure= md_in.results.TransientSolution(end).Pressure;
    end



    md.inversion.iscontrol=0;
    md.transient.isthermal=0;
    md.transient.isgroundingline=1;
    md.masstransport.spcthickness=NaN*ones(md.mesh.numberofvertices,1);

    %Load forcing data
    load './../Data/Atmosphere/ukesm_1931_2030_smb.mat';
    load './../Data/Ocean/ukesm_1931_2030_tf.mat';
    load './../Data/Ocean/deltat_median.mat';
    load './../Data/Ocean/gamma0_median.mat';
    load './../Data/Ocean/basinid.mat';
    load './../Data/Ocean/tf_depths.mat';

    %Set SMB Forcing Parameters
    % ukesm_smb_1931_2030(1:end-1,:) = ukesm_smb_1931_2030 (1:end-1,:);
    md.smb.mass_balance = ukesm_smb_1931_2030 ; %already in m/year ice

    %Set ISMIP6 basal melt rate parameters
    delta_t                     = deltat_median;
    md.basalforcings            = basalforcingsismip6(md.basalforcings);
    md.basalforcings.basin_id   = basinid;
    md.basalforcings.num_basins = length(unique(basinid));
    md.basalforcings.delta_t    = delta_t;
    md.basalforcings.tf_depths  = tf_depths;
    md.basalforcings.gamma_0    = gamma0_median;
    md.basalforcings.tf         = ukesm1_1931_2030_tf;
    md.basalforcings.islocal = 0;

    %Model specifications
    md.outputdefinition.definitions={};
    md.timestepping.interp_forcing=0;
    md.timestepping.start_time=1;
    md.timestepping.final_time=100;
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
