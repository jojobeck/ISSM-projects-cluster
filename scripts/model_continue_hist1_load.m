
function md = model_continue_hist1(md_in_path)
    md_in = loadmodel(md_in_path);
    md = md_in;

    base = md_in.results.TransientSolution(end).Base;
    thickness = md_in.results.TransientSolution(end).Thickness;
    surface = md_in.results.TransientSolution(end).Surface;
    md.geometry.thickness = thickness;
    md.geometry.surface = surface;
    md.geometry.base = base;
    md.mask.ocean_levelset= md_in.results.TransientSolution(end).MaskOceanLevelset;
    md.miscellaneous.name=['hist1_',md.miscellaneous.name];
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
    md.transient.ismasstransport=1;
    md.transient.isstressbalance=1;
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
           


