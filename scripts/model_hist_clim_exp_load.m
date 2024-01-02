function md =model_hist_clim_exp_load(md_in,loadonly)

    md=md_in;
    sz = size(md.results.TransientSolution);
    for i =2:sz(2),
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
