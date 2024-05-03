function md = model_continue_hist1(md_in,i)

    md = md_in;

    time =(i-1)*10;
    base = md_in.results.TransientSolution(i).Base;
    thickness = md_in.results.TransientSolution(i).Thickness;
    surface = md_in.results.TransientSolution(i).Surface;
    md.geometry.thickness = thickness;
    md.geometry.surface = surface;
    md.geometry.base = base;
    md.mask.ocean_levelset= md_in.results.TransientSolution(i).MaskOceanLevelset;
    md.miscellaneous.name=['hist1_timeyear_', num2str(time), '_',md_in.miscellaneous.name];

    md.inversion.iscontrol=0;
    md.transient.isthermal=0;
    md.transient.isgroundingline=1;
    md.transient.ismasstransport=1;
    md.transient.isstressbalance=1;
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
    md.basalforcings.tf         = ukesm1_1850_1994_tf;
    md.basalforcings.islocal = 0;

    %Model specifications
    md.outputdefinition.definitions={};
    md.timestepping.interp_forcing=0;
    md.timestepping.start_time=1;
    md.timestepping.final_time=81;
    md.timestepping.time_step=1/24;
    md.settings.output_frequency=24*25;
    md.transient.requested_outputs={'default','IceVolume','IceVolumeAboveFloatation','GroundedArea','FloatingArea','TotalSmb','SmbMassBalance','TotalGroundedBmb','TotalFloatingBmb','BasalforcingsFloatingiceMeltingRate',...
    'IceVolumeScaled','IceVolumeAboveFloatationScaled','GroundedAreaScaled','FloatingAreaScaled','TotalSmbScaled','TotalGroundedBmbScaled','TotalFloatingBmbScaled'}

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
           


