function plot_after_tuning(steps,md)
    org=organizer('repository',['./Models'],'prefix',['ISMIP6Antarctica_'],'steps',steps, 'color', '34;47;2'); 
    save_fig =false;
    clear steps;

    A_ocean = 361 *10^6 *(1000)^2;
    vol_to_slr = md.materials.rho_ice/(md.materials.rho_freshwater *A_ocean);
    % 1-4
    if perform(org,'Plot_all'),% {{{
        

        % diff = md.results.StressbalanceSolution.Vel-md.initialization.vel;
        diff = md.results.StressbalanceSolution.Vel-md.inversion.vel_obs;
        areas  =GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);


        ice = md.mask.ice_levelset<0;
        rmse_diff = sqrt(mean( diff(ice).^2));
        rmse_area = sqrt( sum( areas(ice)./sum(areas(ice)).*( diff(ice).^2) ) );
        diff_abs=abs(diff);
        tit = [ '|modeled -obs.| vel. RMSE ' , num2str(rmse_diff)];
        tit2 = ['modeled -obs. vel weighted RMSE' , num2str(rmse_area)];
        d1=min(diff(ice));
        d2=max(diff(ice));
        d12=-200;
        d22=200;
        plotmodel(md,...
            'data',md.initialization.vel,'mask',ice,'title','Observed velocity',...
            'data',md.results.StressbalanceSolution.Vel,'mask',ice,'title','Modeled Velocity',...
            'data',diff_abs,'mask',ice,'title',tit ,...
            'data',diff,'mask',ice,'title',tit2,...
            'colorbar#all','on','colorbartitle#1-4','(m/yr)',...
            'caxis#1-2',([0.5,4000]),...
            'caxis#3',([0.5,d2]),...
            'caxis#4',([d12,d22]),...
            'log#1-3',10);
        disp(['has a RMSE of ',num2str(rmse_diff)])
        disp(['max',num2str(d2)]);
        disp(['min',num2str(d1)]);
        if save_fig,
           savefig('./figs/Friction.fig')
        end
            % 'data',md.geometry.base,'title','Bed elevation',...
        % 'data',mds.results.StressbalanceSolution.FrictionCoefficient,'title','Friction Coefficient',...
        % plotmodel(md,'data','mesh','expdisp',{'Domain1.exp'})
    end %}}}
    if perform(org,'Plot_grounded'),% {{{
        % md=loadmodel(filename);


        pos=md.mask.ice_levelset<0;
        pos_grouned=md.mask.ocean_levelset>=0;

        % diff = md.results.StressbalanceSolution.Vel-md.initialization.vel;
        % diff = md.results.StressbalanceSolution.Vel-md.inversion.vel_obs;
        diff = md.results.StressbalanceSolution.Vel-md.inversion.vel_obs;
        d1=min(diff(pos));
        d2=max(diff(pos));
        diff2 =diff;
        % diff2(pos)=0;
        d12=min(diff2(pos_grouned));
        d22=max(diff2(pos_grouned));
        rmse_diff2 = sqrt( mean(diff2(pos_grouned).^2));
        % rmse_diff2_log = sqrt( diff2(pos_grouned).^2);
        % calcualte errors where ice is
        diff_abs=abs(diff);

        rmse_diff = sqrt(mean( diff(pos).^2));
        % calcualte errors where ice is
        tit = ['Diff SSA  velocities RMSE ' , num2str(rmse_diff)];
        tit2 = ['Diff SSA  velocities grounded  RMSE ' , num2str(rmse_diff2)];

        plotmodel(md,...
            'data',diff,'mask',pos_grouned,'title',tit,...
            'data',diff_abs,'mask',pos_grouned,'title',tit2,...
            'colorbar#all','on','colorbartitle#1-2','(m/yr)',...
            'caxis#1',([d12,d22]),...
            'caxis#2',([0.5,d2]),...
            'log#1',10);
    end %}}}
    if perform(org,'Plot_floating'),% {{{
        % md=loadmodel(filename);
        % disp(filename)


        pos=md.mask.ice_levelset<0;
        pos_float= md.mask.ocean_levelset<0;
        pos_grouned=pos & pos_float; %only floaating shelves with ice

        % diff = md.results.StressbalanceSolution.Vel-md.initialization;
        diff = md.results.StressbalanceSolution.Vel-md.inversion.vel_obs;
        d1=min(diff(pos));
        d2=max(diff(pos));
        diff2 =diff;
        % diff2(pos)=0;
        d12=min(diff2(pos_grouned));
        d22=max(diff2(pos_grouned));
        rmse_diff2 = sqrt( mean(diff2(pos_grouned).^2));

        rmse_diff = sqrt(mean( diff(pos).^2));
        % calcualte errors where ice is
        tit = ['modeled -obs. velocities' , num2str(rmse_diff)];
        tit2 = ['modeled - obs. vel RMSE ' , num2str(rmse_diff2)];

        plotmodel(md,...
            'data',diff,'mask',pos_grouned,'title',tit2,...
            'data',diff,'mask',pos_grouned,'title','modeled -obs.  velocities',...
            'colorbar#all','on','colorbartitle#1-2','(m/yr)',...
            'caxis#1',([d12,d22]),...
            'caxis#2',([0.5,d22]),...
            'log#2',10);
        if save_fig,
           savefig('./figs/floating_only.fig')
        end
    end %}}}
    if perform(org,'Plot_floating_mds'),% {{{
        % md=loadmodel(filename);
        % disp(filename)


        pos=md.mask.ice_levelset<0; %ice only
        % pos_float= md.mask.ocean_levelset<0;
        % pos_grouned=pos & pos_float; %only floaating shelves with ice

        % diff = md.results.StressbalanceSolution.Vel-md.initialization;
        diff = md.results.StressbalanceSolution.Vel-md.inversion.vel_obs;
        areas  =GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);
        % weight_area=areas./sum(areas);
        % diff_area = areas.*diff;


        d1=min(diff(pos));
        disp(['min',num2str(d1)]);
        d2=max(diff(pos));
        disp(['max',num2str(d2)]);
        d12 = -200;
        d22 = 200;
        % diff2 =diff;
        % diff2(pos)=0;
        % d12=min(diff2(pos_grouned));
        % d22=max(diff2(pos_grouned));
        % rmse_diff2 = sqrt( mean(diff2(pos_grouned).^2));
        % rmse_diff2_log = sqrt( diff2(pos_grouned).^2);
        % calcualte errors where ice is

        rmse_diff = sqrt(mean( diff(pos).^2));
        rmse_area = sqrt( sum( areas(pos)./sum(areas(pos)).*( diff(pos).^2) ) );
        % calcualte errors where ice is
        tit = ['modeled -obs. vel RMSE' , num2str(rmse_diff)];
        tit2 = ['modeled -obs. vel weighted RMSE' , num2str(rmse_area)];
        % tit2 = ['modeled - obs. vel RMSE ' , num2str(rmse_diff2)];
        disp(tit);
        diff_abs=abs(diff);
        plotmodel(md,...
            'data',diff,'mask',pos,'title',tit,...
            'data',diff_abs,'mask',pos,'title',tit2,...
            'colorbar#all','on','colorbartitle#1-2','(m/yr)',...
            'caxis#1',([d12,d22]),...
            'caxis#2',([0.5,d2]),...
            'log#2',10);
        if save_fig,
           savefig('./figs/floating_only_mds.fig')
        end
    end %}}}
    % 5-6
    if perform(org,'Plot_field'),% {{{
        

        ice = md.mask.ice_levelset<0;

        plotmodel(md,...
            'data',md.friction.coefficient,'mask',ice,'title','friction coefficient',...
            'data',md.materials.rheology_B,'mask',ice,'title','Stiffness B',...
            'data',md.friction.coefficient,'mask',ice,'title','friction coefficient',...
            'data',md.materials.rheology_B,'mask',ice,'title','Stiffness B',...
            'colorbar#all','on','colorbartitle#1','(SI)',...
            'colorbartitle#2','(Pa s^(1/n))',...
            'colorbartitle#3','(SI)',...
            'colorbartitle#4','(Pa s^(1/n))',...
            'log#1-2',10);
            % 'data',md.geometry.base,'title','Bed elevation',...
        % 'data',mds.results.StressbalanceSolution.FrictionCoefficient,'title','Friction Coefficient',...
        % plotmodel(md,'data','mesh','expdisp',{'Domain1.exp'})
    end %}}}
    if perform(org,'find_resason'),% {{{
        

        ice = md.mask.ice_levelset<0;

        plotmodel(md,...
            'data',md.geometry.bed,'mask',ice,'title','bedrock',...
            'data',md.mask.ocean_levelset,'mask',ice,'title','thk a.fl.',...
            'data',md.friction.coefficient,'mask',ice,'title','friction coefficient',...
            'data',md.geometry.thickness,'mask',ice,'title','thickness',...
            'colorbar#all','on','colorbartitle#1','(m)',...
            'colorbartitle#2','(Pa s^(1/n))',...
            'colorbartitle#3','(SI)',...
            'colorbartitle#4','(Pa s^(1/n))');
        nm = ['./figs/' md.miscellaneous.name 'friction.fig'];
        if save_fig;
            savefig(nm);
        end
    end %}}}
    % 7-9
    if perform(org,'Plot_all_SSA_vel2d'),% {{{
        % filename = './Models/ISMIP6Antarctica_RunInitSSA.mat';
        % md=loadmodel(filename);
        sz = size(md.results.TransientSolution);
        % diff = md.results.StressbalanceSolution.Vel-md.initialization.vel;
        diff = md.results.TransientSolution(end).Vel-md.inversion.vel_obs;
        diff_sim = md.results.TransientSolution(end).Vel-md.results.TransientSolution(1).Vel;


        pos=md.mask.ice_levelset<0; %ice only
        % pos_float= md.mask.ocean_levelset<0;
        % pos_grouned=pos & pos_float; %only floaating shelves with ice

        % diff = md.results.StressbalanceSolution.Vel-md.initialization;
        d1=min(diff(pos));
        disp(['min',num2str(d1)]);
        d2=max(diff(pos));
        disp(['max',num2str(d2)]);
        d12 = -200;
        d22 = 200;
        % diff2 =diff;
        % diff2(pos)=0;
        % d12=min(diff2(pos_grouned));
        % d22=max(diff2(pos_grouned));
        % rmse_diff2 = sqrt( mean(diff2(pos_grouned).^2));
        % rmse_diff2_log = sqrt( diff2(pos_grouned).^2);
        % calcualte errors where ice is

        rmse_diff = sqrt(mean( diff(pos).^2));
        rmse_diff2 = sqrt(mean( diff_sim(pos).^2));
        % calcualte errors where ice is
        tit = ['modelled 100y -obs. vel RMSE' , num2str(rmse_diff)];
        tit2 = ['modelled 100y -1. vel RMSE' , num2str(rmse_diff2)];

        % tit2 = ['modeled - obs. vel RMSE ' , num2str(rmse_diff2)];
        disp(tit);
        diff_abs=abs(diff);
        plotmodel(md,...
            'data',diff,'mask',pos,'title',tit,...
            'data',diff_sim,'mask',pos,'title',tit2,...
            'data',abs(diff),'mask',pos,'title','diff modeled y100 - obs',...
            'data',abs(diff_sim),'mask',pos,'title','diff modelled y100 -y0',...
            'caxis#1-2',[d12,d22],...
            'log#3-4',10);
        if save_fig,
            nm = ['./figs/' md.miscellaneous.name '2dVel.fig'];
            savefig(nm);
        end
    end %}}}
    if perform(org,'Plot_all_SSA_time'),% {{{
        sz = size(md.results.TransientSolution);
        t = zeros(sz);
        for i =1:sz(2)
            t(i) = md.results.TransientSolution(i).time;
        end


        pos=md.mask.ice_levelset<0; %ice only
        figure

        %Plot surface mass balance
        vel=[]; for i=1:length(t);vel=[vel...
            max(md.results.TransientSolution(i).Vel(pos))]; end
        subplot(4,1,1); plot(t,vel); title('maximum velocity');

        %Plot volume above flotation
        vol=[]; for i=1:length(t); vol=[vol md.results.TransientSolution(i).IceVolumeAboveFloatation*vol_to_slr]; end
        subplot(4,1,2); plot(t,vol); title('Ice Volume above flotation (SLR-equivalent (m)');
        
        

        %Plot Volume
        volume=[]; for i=1:length(t); volume=[volume md.results.TransientSolution(i).IceVolume]; end
        subplot(4,1,3); plot(t,volume); title('Ice Volume (m3)');
        area=[]; for i=1:length(t); area=[area md.results.TransientSolution(i).GroundedArea]; end
        subplot(4,1,4); plot(t,area); title('grounded area (m2)');
        xlabel('years')
        if save_fig,
            nm = ['./figs/' md.miscellaneous.name 'timeseries.fig'];
            savefig(nm);
        end


    end %}}}
    if perform(org,'Plot_all_SSA_2dchanges'),% {{{
        sz = size(md.results.TransientSolution);
        grA1 =md.results.TransientSolution(1).MaskOceanLevelset >0;
        grA2 =md.results.TransientSolution(end).MaskOceanLevelset >0;
        diffA = grA1 - grA2 ;% 1 gr area rerteat, 0 no change , -1 gr. Area adwance
        diff_sim = md.results.TransientSolution(1).Thickness - md.results.TransientSolution(end).Thickness;

        
        pos=md.mask.ice_levelset<0; %ice only

        plotmodel(md,...
            'data',diff_sim,'mask',pos,'title','thickness  change y0 -y100',...
            'data',diffA,'mask',pos,'title','grounded area retreat(1)/ advance(-1)')
        if save_fig,
            nm = ['./figs/' md.miscellaneous.name '2dChanges.fig'];
            savefig(nm);
        end

    end %}}}
    % 10-11
    if perform(org,'Plot_all-HO'),% {{{

        surf=find(md.mesh.vertexonsurface);
        % diff = md.results.StressbalanceSolution.Vel-md.initialization.vel;
        diff = md.results.StressbalanceSolution.Vel(surf)-md.inversion.vel_obs(surf);
        mds = md.collapse();

        areas  =GetAreas(mds.mesh.elements,mds.mesh.x,mds.mesh.y);

        ice = md.mask.ice_levelset<0;% apperently still needed for plotting 
        ice_surf = md.mask.ice_levelset(surf)<0;% fore calculatin only on surface
        rmse_diff = sqrt(mean( diff(ice_surf).^2));
        rmse_area = sqrt( sum( areas(ice_surf)./sum(areas(ice_surf)).*( diff(ice_surf).^2) ) );
        diff_abs=abs(diff);
        tit = [ '|modeled -obs.| vel. RMSE ' , num2str(rmse_diff)];
        tit2 = ['modeled -obs. vel weighted RMSE' , num2str(rmse_area)];
        d1=min(diff(ice_surf));
        d2=max(diff(ice_surf));
        d12=-200;
        d22=200;
        plotmodel(md,...
            'data',md.initialization.vel(surf),'mask',ice,'title','Observed velocity',...
            'data',md.results.StressbalanceSolution.Vel(surf),'mask',ice,'title','Modeled Velocity',...
            'data',diff_abs,'mask',ice,'title',tit ,...
            'data',diff,'mask',ice,'title',tit2,...
            'colorbar#all','on','colorbartitle#1-4','(m/yr)',...
            'caxis#1-2',([0.5,4000]),...
            'caxis#3',([0.5,d2]),...
            'caxis#4',([d12,d22]),...
            'log#1-3',10,...
            'view#all',2);
        disp(['has a RMSE of ',num2str(rmse_diff)])
        disp(['max',num2str(d2)]);
        disp(['min',num2str(d1)]);
        if save_fig,
           savefig('./figs/FrictionHO.fig')
        end
            % 'data',md.geometry.base,'title','Bed elevation',...
        % 'data',mds.results.StressbalanceSolution.FrictionCoefficient,'title','Friction Coefficient',...
        % plotmodel(md,'data','mesh','expdisp',{'Domain1.exp'})
    end %}}}
    if perform(org,'Plot-HO-mds'),% {{{

        surf=find(md.mesh.vertexonsurface);
        diff_plot = md.results.StressbalanceSolution.Vel-md.initialization.vel;
        diff = md.results.StressbalanceSolution.Vel(surf)-md.inversion.vel_obs(surf);
        mds = md.collapse();

        areas  =GetAreas(mds.mesh.elements,mds.mesh.x,mds.mesh.y);

        ice = md.mask.ice_levelset<0;% apperently still needed for plotting 
        ice_surf = md.mask.ice_levelset(surf)<0;% fore calculatin only on surface
        rmse_diff = sqrt(mean( diff(ice_surf).^2));
        rmse_area = sqrt( sum( areas(ice_surf)./sum(areas(ice_surf)).*( diff(ice_surf).^2) ) );
        diff_abs=abs(diff_plot);
        tit = [ '|modeled -obs.| vel. RMSE ' , num2str(rmse_diff)];
        tit2 = ['modeled -obs. vel weighted RMSE' , num2str(rmse_area)];
        d1=min(diff(ice_surf));
        d2=max(diff(ice_surf));
        d12=-200;
        d22=200;
        plotmodel(md,...
            'data',diff_abs,'mask',ice,'title',tit ,...
            'data',diff_plot,'mask',ice,'title',tit2,...
            'colorbar#all','on','colorbartitle#1-2','(m/yr)',...
            'caxis#1',([0.5,d2]),...
            'caxis#2',([d12,d22]),...
            'log#1',10,...
            'layer#1-2',10);
        disp(['has a RMSE of ',num2str(rmse_diff)])
        disp(['max',num2str(d2)]);
        disp(['min',num2str(d1)]);
        if save_fig,
           savefig('./figs/afterinversionB.fig')
        end
            % 'data',md.geometry.base,'title','Bed elevation',...
        % 'data',mds.results.StressbalanceSolution.FrictionCoefficient,'title','Friction Coefficient',...
        % plotmodel(md,'data','mesh','expdisp',{'Domain1.exp'})
    end %}}}
    %12
if perform(org,'PlotFriction'),% {{{ 
	md1=loadmodel('Models/ISMIP6Antarctica_CollapseSSA.mat');

    areas  =GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);
    ice = md.mask.ice_levelset<0;% apperently still needed for plotting 
    tit = 'SSA inversion'
    tit1 = 'original collapsed'
    plotmodel(md,'figure',1,...
    'data',md.results.StressbalanceSolution.FrictionCoefficient,'mask',ice,'title',tit,...
    'data',md1.friction.coefficient,'mask',ice,'title',tit1,...
    'colorbar#all','on',...
    'caxis#all',([0,500]),...
    'view#all',2);
    c_lim=2000;
    C=redwhiteblue(-c_lim,c_lim);
    diff = md1.friction.coefficient-md.friction.coefficient;
    rmse_area = sqrt( sum( areas(ice)./sum(areas(ice)).*( diff(ice).^2) ) );
    % tito = 'collapse - ssa inversion'
    tito = ['collapse - ssa inversion. vel weighted RMSE' , num2str(rmse_area)];
    ice = md.mask.ocean_levelset>0;% apperently still needed for plotting 
    plotmodel(md,'figure',2,...
    'data',diff,'mask',ice,'title',tito,...
    'caxis#all',([-c_lim,c_lim]),...
    'colormap#all',C,...
    'colorbar#all','on',...
    'view#all',2);
end% }}}
if perform(org,'PlotFriction_retreat'),% {{{ 
	md1=loadmodel('Models/ISMIP6Antarctica_CollapseSSA.mat');
    c_data = double(ncread("Data/Fields/friction_coefficient_nn.nc","friction_c"));
    x=[min(md.mesh.x):1000:max(md.mesh.x)];   
    y=[min(md.mesh.y):1000:max(md.mesh.y)];   
    friction_c = InterpFromGrid(y,x,c_data,md.mesh.y,md.mesh.x,'nearest');
    m_data = double(ncread("Data/Fields/retreated_diff_mask_grounded.nc","mask_grounded"));
    mask_retreat = InterpFromGrid(y,x,m_data,md.mesh.y,md.mesh.x,'nearest');
    md1.friction.coefficient=friction_c;

    areas  =GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);
    ice = md.mask.ice_levelset<0;% apperently still needed for plotting 
    tit = 'SSA inversion'
    tit1 = 'before imnersion'
    plotmodel(md,'figure',1,...
    'data',md.friction.coefficient,'mask',ice,'title',tit,...
    'data',md1.friction.coefficient,'mask',ice,'title',tit1,...
    'colorbar#all','on',...
    'caxis#all',([0,500]),...
    'view#all',2);
    c_lim=500;
    C=redwhiteblue(-c_lim,c_lim);
    diff = md1.friction.coefficient-md.friction.coefficient;
    rmse_area = sqrt( sum( areas(ice)./sum(areas(ice)).*( diff(ice).^2) ) );
    % tito = 'collapse - ssa inversion'
    tito = ['collapse - ssa inversion. vel weighted RMSE' , num2str(rmse_area)];
    ice = md.mask.ocean_levelset>0;% apperently still needed for plotting 
    plotmodel(md,'figure',2,...
    'data',diff,'mask',ice,'title',tito,...
    'caxis#all',([-c_lim,c_lim]),...
    'colormap#all',C,...
    'colorbar#all','on',...
    'view#all',2);
end% }}}
    if perform(org,'Plot_floating_melt'),% {{{
        % md=loadmodel(filename);
        % disp(filename)


        pos=md.mask.ice_levelset<0;
        pos_float= md.mask.ocean_levelset<0;
        pos_grouned=pos & pos_float; %only floaating shelves with ice

        % diff = md.results.StressbaldanceSolution.Vel-md.initialization;
        d12=0,
        d22 =30,
        tit2 = 'basalmelt';
        plotmodel(md,...
            'data',md.results.TransientSolution(end).BasalforcingsFloatingiceMeltingRate,'mask',pos_grouned,'title',tit2,...
            'colorbar#all','on','colorbartitle#1','(m/yr)',...
            'caxis#1',([d12,d22]))
        if save_fig,
           savefig('./figs/floating_only.fig')
        end
    end %}}}
    %1
    if perform(org,'Plot_melt_SSA_time'),% {{{
        sz = size(md.results.TransientSolution);
        t = zeros(sz);
        for i =1:sz(2)
            t(i) = md.results.TransientSolution(i).time;
        end
        t=t+1931;


        pos=md.mask.ice_levelset<0; %ice only
        figure

        %Plot surface mass balance
        
        

        %Plot Volume
        volume=[]; for i=1:length(t); volume=[volume md.results.TransientSolution(i).TotalFloatingBmb]; end
        subplot(5,1,1); plot(t,volume); title('Total basal melt (m)');
        msk = md.basalforcings.basin_id == 10;
        basin = md.basalforcings.basin_id;
        basin(~msk)=nan;
        areas=GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);
        data_vertices=sparse(md.mesh.elements(:),ones(numel(md.mesh.elements),1),repmat(areas.*basin,3,1),md.mesh.numberofvertices,1);
        ms = isnan( data_vertices);
        data_vertices(~ms)=10;

        area=[]; for i=1:length(t); area=[area mean(md.results.TransientSolution(i).BasalforcingsFloatingiceMeltingRate(~ms))]; end
        mean20 =zeros(sz-2);
        n =  sz(2)-20;
        mean20 = zeros([1 n]) ;
        for i=1:length(mean20); mean20(i)=mean(area(i:i+19)); end
        imin=find(min(mean20) == mean20);
        tavg= t(11:length(t)-10),
        subplot(5,1,2); plot(t,area); title('avg melt basin 10');
        tit =['20 year running mean, min from ',num2str(t(imin)),'-',num2str(t(imin+19))]

        subplot(5,1,3);plot(tavg,mean20);title(tit);
        
        msk = md.basalforcings.basin_id == 5;
        basin = md.basalforcings.basin_id;
        basin(~msk)=nan;
        areas=GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);
        data_vertices=sparse(md.mesh.elements(:),ones(numel(md.mesh.elements),1),repmat(areas.*basin,3,1),md.mesh.numberofvertices,1);
        ms = isnan( data_vertices);
        data_vertices(~ms)=10;

        area=[]; for i=1:length(t); area=[area mean(md.results.TransientSolution(i).BasalforcingsFloatingiceMeltingRate(~ms))]; end
        mean20 =zeros(sz-2);
        n =  sz(2)-20;
        mean20 = zeros([1 n]) ;
        for i=1:length(mean20); mean20(i)=mean(area(i:i+19)); end
        imin=find(min(mean20) == mean20);
        tavg= t(11:length(t)-10),
        subplot(5,1,4); plot(t,area); title('avg melt basin 5');
        tit =['20 year running mean, min from ',num2str(t(imin)),'-',num2str(t(imin+19))]

        subplot(5,1,5);plot(tavg,mean20);title(tit);


        xlabel('years')
        if save_fig,
            nm = ['./figs/' md.miscellaneous.name '_melting_timeseries.fig'];
            savefig(nm);
        end

end% }}} 
    if perform(org,'Plot_gl_change'),% {{{
        sz = size(md.results.TransientSolution);
        ice =md.mask.ice_levelset <0;
        c_lim=4000;
        C=redwhiteblue(-c_lim,c_lim);
        % p_vel = '/Users/jbec0008/SAEF/datasets/bedrock/';
        % vel_set = "BedMachineAntarctica-v3.nc";
        % bedm = fullfile(p_vel, vel_set);
        % mask = interpBedmachineAntarctica(md.mesh.x,md.mesh.y,'mask','nearest',bedm);
        % mask_bedmachine =mask;

        % %    Get necessary data to build up the velocity grid
        % %   mask:flag_values = 0b, 1b, 2b, 3b, 4b ;
        % %   mask:flag_meanings = "ocean ice_free_land grounded_ice floating_ice lake_vostok" ;


        % % mask = interpBedmachineAntarctica(md.mesh.x,md.mesh.y,'mask','nearest','2019-11-05_v01');
        % pos = find(mask==0 | mask==3);
        % mask_bedmachine(pos)=-1; %negtive for ocean and floating ice and positive everywhere else assumign grounded ice!
        % pos = find(mask==2 | mask==4);
        % mask_bedmachine(pos) =1;


        % tito = 'collapse - ssa inversion'
        % plotmodel(md,...
        % 'data',md.geometry.bed,'mask',ice,...
        % 'colormap#all',C,...
        % 'colorbar#all','on',...
        % 'view#all',2);
        % plotmodel(md,'data',md.basalforcings.basin_id)
        plotmodel(md,'data',md.friction.coefficient,'caxis',[0,500]);
        % c_lim=1000;
        % C=redwhiteblue(-c_lim,c_lim);
        % plotmodel(md,'data',md.geometry.bed,...
        % 'colormap#all',C,...
        % 'colorbar#all','on',...
        % 'caxis#all',([-c_lim,c_lim]));
        h = legend('show','location','best');
        set(h,'FontSize',12);
        h0=isoline(md,md.mask.ocean_levelset,'value',0,'output','matrix');
        hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','y0');
        % h0=isoline(md,mask_bedmachine,'value',0,'output','matrix');
        % hold on; plot(h0(:,1),h0(:,2),'-','Color','blue','LineWidth',5,'Displayname','bedmachine');
        CM = jet(sz(2));
        cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
        set(gca(),'ColorOrder',cmap)
        for ii=1:sz(2)
           hii=isoline(md,md.results.TransientSolution(ii).MaskOceanLevelset,'value',0,'output','matrix','Displayname',ii);
           hold on; plot(hii(:,1),hii(:,2),'-');
        end
end% }}} 
    if perform(org,'Plot_gl_change_SMB'),% {{{
        sz = size(md.results.TransientSolution);
        ice =md.mask.ice_levelset <0;


        c_lim=1000;
        C=redwhiteblue(-c_lim,c_lim);
        % tito = 'collapse - ssa inversion'
        % plotmodel(md,...
        % 'data',md.geometry.bed,'mask',ice,...
        % 'colormap#all',C,...
        % 'colorbar#all','on',...
        % 'view#all',2);
        % plotmodel(md,'data',md.basalforcings.basin_id)
        plotmodel(md,...
        'data',md.results.TransientSolution(1).SmbMassBalance,'caxis',[0,3]);

        h = legend('show','location','best');
        set(h,'FontSize',12);
        h0=isoline(md,md.mask.ocean_levelset,'value',0,'output','matrix');
        hc=isoline(md,md.mask.ice_levelset,'value',0,'output','matrix');
        hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','y0');
        hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
        CM = jet(sz(2));
        cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
        set(gca(),'ColorOrder',cmap)
        for ii=1:sz(2)
           hii=isoline(md,md.results.TransientSolution(ii).MaskOceanLevelset,'value',0,'output','matrix','Displayname',ii);
           hold on; plot(hii(:,1),hii(:,2),'-');
        end
end% }}} 
    if perform(org,'Plot_gl_change_bed'),% {{{
        sz = size(md.results.TransientSolution);
        ice =md.mask.ice_levelset <0;


        c_lim=1000;
        C=whiteblue(-c_lim,c_lim);
        % tito = 'collapse - ssa inversion'
        % plotmodel(md,...
        % 'data',md.geometry.bed,'mask',ice,...
        % 'colormap#all',C,...
        % 'colorbar#all','on',...
        % 'view#all',2);
        % plotmodel(md,'data',md.basalforcings.basin_id)
        plotmodel(md,...
        'data',md.geometry.bed,...
        'colormap',C,...
        'caxis',[-1000,-500],...
        'colorbar#all','on');

        h = legend('show','location','best');
        set(h,'FontSize',12);
        h0=isoline(md,md.mask.ocean_levelset,'value',0,'output','matrix');
        hc=isoline(md,md.mask.ice_levelset,'value',0,'output','matrix');
        hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','y0');
        hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
        CM = jet(sz(2));
        cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
        set(gca(),'ColorOrder',cmap)
        for ii=1:sz(2)
           hii=isoline(md,md.results.TransientSolution(ii).MaskOceanLevelset,'value',0,'output','matrix','Displayname',ii);
           hold on; plot(hii(:,1),hii(:,2),'-');
        end
end% }}} 
    if perform(org,'Plot_gl_change_mask'),% {{{
        sz = size(md.results.TransientSolution);
        ice =md.mask.ice_levelset <0;


        c_lim=1000;
        C=redwhiteblue(-c_lim,c_lim);
        % tito = 'collapse - ssa inversion'
        % plotmodel(md,...
        % 'data',md.geometry.bed,'mask',ice,...
        % 'colorbar#all','on',...
        % 'view#all',2);
        % plotmodel(md,'data',md.basalforcings.basin_id)
        plotmodel(md,...
        'data',md.mask.ocean_levelset,...
        'caxis',[-c_lim,0]);

        % 'colormap#all',C,...
        h = legend('show','location','best');
        set(h,'FontSize',12);
        h0=isoline(md,md.mask.ocean_levelset,'value',0,'output','matrix');
        hc=isoline(md,md.mask.ice_levelset,'value',0,'output','matrix');
        hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','y0');
        hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
        CM = jet(sz(2));
        cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
        set(gca(),'ColorOrder',cmap)
        for ii=1:sz(2)
           hii=isoline(md,md.results.TransientSolution(ii).MaskOceanLevelset,'value',0,'output','matrix','Displayname',ii);
           hold on; plot(hii(:,1),hii(:,2),'-');
        end
end% }}} 
    if perform(org,'Plot_gl_change_mask_end'),% {{{
        sz = size(md.results.TransientSolution);
        ice =md.mask.ice_levelset <0;


        c_lim=1000;
        C=redwhiteblue(-c_lim,c_lim);
        mocean = md.results.TransientSolution(end).MaskOceanLevelset;
        % tito = 'collapse - ssa inversion'
        % plotmodel(md,...
        % 'data',md.geometry.bed,'mask',ice,...
        % 'colorbar#all','on',...
        % 'view#all',2);
        % plotmodel(md,'data',md.basalforcings.basin_id)
        plotmodel(md,...
        'data',mocean,...
        'caxis',[-c_lim,0]);

        % 'colormap#all',C,...
        h = legend('show','location','best');
        set(h,'FontSize',12);
        h0=isoline(md,mocean,'value',0,'output','matrix');
        hc=isoline(md,md.mask.ice_levelset,'value',0,'output','matrix');
        hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','y0');
        hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
        CM = jet(sz(2));
        cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
        set(gca(),'ColorOrder',cmap)
        for ii=1:sz(2)
           hii=isoline(md,md.results.TransientSolution(ii).MaskOceanLevelset,'value',0,'output','matrix','Displayname',ii);
           hold on; plot(hii(:,1),hii(:,2),'-');
        end
end% }}} 
% plotmodel(md,'data','vertexnumbering','xlim',[-2 -1]*10^6,'ylim',[-1 -0.5]*10^6)
