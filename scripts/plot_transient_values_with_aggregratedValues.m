function plot_after_tuning(md,steps,save_fig)
    org=organizer('repository',['./Models'],'prefix',['ISMIP6Antarctica_'],'steps',steps, 'color', '34;47;2'); 
    if ~exist('save_fig','var')
     % if 1, save figures
      save_fig = 0;
    end


    clear steps;
    addpath('../scripts/');

    A_ocean = 361 *10^6 *(1000)^2;
    vol_to_slr = md.materials.rho_ice/(md.materials.rho_freshwater *A_ocean);
    % 1-4
    % 7-9
    if perform(org,'Plot_all_2d'),% {{{
        % filename = './Models/ISMIP6Antarctica_RunInitSSA.mat';
        % md=loadmodel(filename);
        sz = size(md.results.TransientSolution);
        % diff = md.results.StressbalanceSolution.Vel-md.initialization.vel;
        diff_sim = md.results.TransientSolution(end).Vel-md.results.TransientSolution(1).Vel;

        diff_sim_H = md.results.TransientSolution(end).Thickness-md.results.TransientSolution(1).Thickness;
        diff_sim_bm = md.results.TransientSolution(end).BasalforcingsFloatingiceMeltingRate-md.results.TransientSolution(1).BasalforcingsFloatingiceMeltingRate;

        pos=md.mask.ice_levelset<0; %ice only
        pos_float= md.mask.ocean_levelset<0;
        pos_grouned=pos & pos_float; %only floaating shelves with ice
        % pos_float= md.mask.ocean_levelset<0;
        % pos_grouned=pos & pos_float; %only floaating shelves with ice

        % diff = md.results.StressbalanceSolution.Vel-md.initialization;
        d1=min(diff_sim(pos));
        d2=max(diff_sim(pos));
        d = max(abs(d1),abs(d2));
        d=d/2;
        C=redwhiteblue(-d,d);
        dh_i = get_d_for_colormax(diff_sim_H(pos));
        dbm_i = get_d_for_colormax(diff_sim_bm(pos_grouned));
        dh =dh_i/2;
        dbm=dbm_i/2;
        Ch=redwhiteblue(-dh,dh);
        Cbm=redwhiteblue(-dbm,dbm);


        % calcualte errors where ice is
        tit2 = ['modelled last y -1. vel'];
        fl1 = expread('./../Exp/PIG_fl_drawn.exp');
        fl2 = expread('./../Exp/THW_fl_drawn.exp');

        % tit2 = ['modeled - obs. vel RMSE ' , num2str(rmse_diff2)];
        figure
        % Subplot 1

        plotmodel(md,...
            'data',diff_sim,'mask',pos,'title',tit2,...
            'data',abs(diff_sim),'mask',pos,'title','diff modelled yend -y0',...
            'data',diff_sim_H,'mask',pos,'title','thickness y end - 1y0',...
            'data',diff_sim_bm,'mask',pos_grouned,'title','basal melt y end - 1y0',...
            'data',md.results.TransientSolution(end).BasalforcingsFloatingiceMeltingRate,'mask',pos_grouned,'title','basal melt y end ',...
            'caxis#1',[-d,d],...
            'caxis#2',[0.5,3000],...
            'caxis#3',[-dh,dh],...
            'caxis#3',[-dbm,dbm],...
            'colormap#1',C,...
            'colormap#3',Ch,...
            'colormap#4',Cbm,...
            'log#2',10);
        hold on; plot(fl1.x,fl1.y,'-','Color','black','LineWidth',5);
        hold on; plot(fl2.x,fl2.y,'-','Color','black','LineWidth',5);
        hold off;

        if save_fig,
            nm = ['./figs/transienteval/' md.miscellaneous.name '2dVel_allAIS.fig'];
            savefig(nm);
        end
    end %}}}
    if perform(org,'Plot_all_2d_basin_10'),% {{{
        % filename = './Models/ISMIP6Antarctica_RunInitSSA.mat';
        % md=loadmodel(filename);
        sz = size(md.results.TransientSolution);
        % diff = md.results.StressbalanceSolution.Vel-md.initialization.vel;
        diff_sim = md.results.TransientSolution(end).Vel-md.results.TransientSolution(1).Vel;

        diff_sim_H = md.results.TransientSolution(end).Thickness-md.results.TransientSolution(1).Thickness;
        diff_sim_bm = md.results.TransientSolution(end).BasalforcingsFloatingiceMeltingRate-md.results.TransientSolution(1).BasalforcingsFloatingiceMeltingRate;

        pos1=md.mask.ice_levelset<0; %ice only
        msk = md.basalforcings.basin_id == 10;
        basin = md.basalforcings.basin_id;
        basin(~msk)=nan;
        areas=GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);
        data_vertices=sparse(md.mesh.elements(:),ones(numel(md.mesh.elements),1),repmat(areas.*basin,3,1),md.mesh.numberofvertices,1);
        ms = isnan( data_vertices);
        pos = pos1 & ~ms;
        pos_float= md.mask.ocean_levelset<0;
        pos_grouned=pos & pos_float; %only floaating shelves with ice
        % pos_float= md.mask.ocean_levelset<0;
        % pos_grouned=pos & pos_float; %only floaating shelves with ice

        % diff = md.results.StressbalanceSolution.Vel-md.initialization;
        d1=min(diff_sim(pos));
        d2=max(diff_sim(pos));
        d = max(abs(d1),abs(d2));
        d=d/2;
        C=redwhiteblue(-d,d);
        dh_i = get_d_for_colormax(diff_sim_H(pos));
        dbm_i = get_d_for_colormax(diff_sim_bm(pos_grouned));
        dh =dh_i/2;
        dbm=dbm_i/2;
        Ch=redwhiteblue(-dh,dh);
        Cbm=redwhiteblue(-dbm,dbm);


        % calcualte errors where ice is
        tit2 = ['modelled last y -1. vel'];
        fl1 = expread('./../Exp/PIG_fl_drawn.exp');
        fl2 = expread('./../Exp/THW_fl_drawn.exp');

        % tit2 = ['modeled - obs. vel RMSE ' , num2str(rmse_diff2)];
        figure
        % Subplot 1

        plotmodel(md,...
            'data',diff_sim,'mask',pos,'title',tit2,...
            'data',abs(diff_sim),'mask',pos,'title','diff modelled yend -y0',...
            'data',diff_sim_H,'mask',pos,'title','thickness y end - 1y0',...
            'data',diff_sim_bm,'mask',pos_grouned,'title','basal melt y end - 1y0',...
            'data',md.results.TransientSolution(end).BasalforcingsFloatingiceMeltingRate,'mask',pos_grouned,'title','basal melt y end ',...
            'caxis#1',[-d,d],...
            'caxis#2',[0.5,3000],...
            'caxis#3',[-dh,dh],...
            'caxis#3',[-dbm,dbm],...
            'colormap#1',C,...
            'colormap#3',Ch,...
            'colormap#4',Cbm,...
            'log#2',10,...
            'xlim#all',[-1.9e6,-1.0e6],...
            'ylim#all',[-7e5,1e5]);
        hold on; plot(fl1.x,fl1.y,'-','Color','black','LineWidth',5);
        hold on; plot(fl2.x,fl2.y,'-','Color','black','LineWidth',5);
        hold off;

        if save_fig,
            nm = ['./figs/transienteval/' md.miscellaneous.name '2dVel_basin10.fig'];
            savefig(nm);
        end
    end %}}}
    if perform(org,'Plot_all_sectionvaues_PIG'),% {{{
        res = 1000;
        exp_file = './../Exp/PIG_fl_drawn.exp';
        sz = size(md.results.TransientSolution);
        directory = 'Data/Tables';
        model_name= md.miscellaneous.name;
        [~, basename, ~] = fileparts(exp_file);
        filename1 = fullfile(directory, sprintf('%s_temporalVelocity_%s.csv', basename,model_name));


        filename2 = fullfile(directory, sprintf('%s_temporalSurface_%s.csv', basename,model_name));
        filename3 = fullfile(directory, sprintf('%s_temporalGl_%s.csv', basename,model_name));
        filename4 = fullfile(directory, sprintf('%s_temporalBase_%s.csv', basename,model_name));

        n = readtable(filename1);
        n2 = readtable(filename2);
        n3 = readtable(filename3);
        n4 = readtable(filename4);
        t =n.Variables;
        t2 =n2.Variables;
        t3 =n3.Variables;
        t4 =n4.Variables;
        nsz = size(t);
        cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
        nsz = size(t);
        dist =[];
        for i =2:nsz(1),
            dist =[dist i*res];
        end
        figure; 
        hold on;
        subplot(2,1,1);
        set(gca(),'ColorOrder',cmap)
        for i=1:sz(2),
            ti=flip( t(2:end,i));

            t3_i = flip(t3(2:end,i));
            pos = find(t3_i < 0);
           hold on; 
            % hold on;scatter( dist(pos(1)),ti(pos(1)));
            scatter( dist(pos(1)),ti(pos(1)));
            plot(dist,ti,'Displayname',[num2str(i)]);
            % hold on;plot(dist,ti,'Displayname',[num2str(i)]);
        end
        [~,~,~,~,~,bed_in] = SectionValues(md,md.geometry.bed,exp_file,res);
        bed = flip(bed_in);
        title('PIG Velocity (m/a)');
        legend('Location','best');
        hold off;

        subplot(2,1,2);
        hold on;
        set(gca(),'ColorOrder',cmap)
        for i=1:sz(2),
            ti= flip(t2(2:end,i));
            plot(dist,ti);
            tj= flip(t4(2:end,i));
            plot(dist,tj);
        end
        title('PIG cross_section (m)');
        plot(dist,bed,'color','black')

        hold off;

        if save_fig,
            nm = ['./figs/transienteval/' md.miscellaneous.name '_PIG_crossection.fig'];
            savefig(nm);
        end

        % plotmodel(md,'data',md.geometry.thickness,'sectionvalue', './../Exp/PIG_fl_drawn.exp','resolution',[1 1],'figure',1)
        % for step = 1:numel(md.results.TransientSolution)
        %     plotmodel(md,'data',md.results.TransientSolution(step).Thickness,'sectionvalue', './../Exp/PIG_fl_drawn.exp','resolution',[1 1],'figure',1)
        % end

        % Subplot 1

    end %}}}
    if perform(org,'Plot_all_sectionvaues_THW'),% {{{
        res = 1000;
        exp_file = './../Exp/THW_fl_drawn.exp';
        sz = size(md.results.TransientSolution);
        directory = 'Data/Tables';
        model_name= md.miscellaneous.name;
        [~, basename, ~] = fileparts(exp_file);
        filename1 = fullfile(directory, sprintf('%s_temporalVelocity_%s.csv', basename,model_name));


        filename2 = fullfile(directory, sprintf('%s_temporalSurface_%s.csv', basename,model_name));
        filename3 = fullfile(directory, sprintf('%s_temporalGl_%s.csv', basename,model_name));
        filename4 = fullfile(directory, sprintf('%s_temporalBase_%s.csv', basename,model_name));

        n = readtable(filename1);
        n2 = readtable(filename2);
        n3 = readtable(filename3);
        n4 = readtable(filename4);
        t =n.Variables;
        t2 =n2.Variables;
        t3 =n3.Variables;
        t4 =n4.Variables;
        nsz = size(t);
        cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
        nsz = size(t);
        dist =[];
        for i =2:nsz(1),
            dist =[dist i*res];
        end
        figure; 
        hold on;
        subplot(2,1,1);
        set(gca(),'ColorOrder',cmap)
        for i=1:sz(2),
            ti=flip( t(2:end,i));

            t3_i = flip(t3(2:end,i));
            pos = find(t3_i < 0);
           hold on; 
            % hold on;scatter( dist(pos(1)),ti(pos(1)));
            scatter( dist(pos(1)),ti(pos(1)));
            plot(dist,ti,'Displayname',[num2str(i)]);
            % hold on;plot(dist,ti,'Displayname',[num2str(i)]);
        end
        [~,~,~,~,~,bed_in] = SectionValues(md,md.geometry.bed,exp_file,res);
        bed = flip(bed_in);
        title('THW Velocity (m/a)');
        legend('Location','best');
        hold off;

        subplot(2,1,2);
        hold on;
        set(gca(),'ColorOrder',cmap)
        for i=1:sz(2),
            ti= flip(t2(2:end,i));
            plot(dist,ti);
            tj= flip(t4(2:end,i));
            plot(dist,tj);
        end
        title('THW cross_section (m)');
        plot(dist,bed,'color','black')

        hold off;

        if save_fig,
            nm = ['./figs/transienteval/' md.miscellaneous.name '_THW_crossection.fig'];
            savefig(nm);
        end

        % plotmodel(md,'data',md.geometry.thickness,'sectionvalue', './../Exp/PIG_fl_drawn.exp','resolution',[1 1],'figure',1)
        % for step = 1:numel(md.results.TransientSolution)
        %     plotmodel(md,'data',md.results.TransientSolution(step).Thickness,'sectionvalue', './../Exp/PIG_fl_drawn.exp','resolution',[1 1],'figure',1)
        % end

        % Subplot 1

    end %}}}
    if perform(org,'Plot_aggregated_values_basin'),% {{{
        num =10;
        basinName = md.miscellaneous.name;
        directory = 'Data/Tables';
        filename = fullfile(directory, sprintf('AggregatedValues_%s_basin_%d.csv', basinName, num));
        table = readtable(filename);
        V =table.Variables;
        [t,vars]= size(table);
        time = zeros(t,1);
        for i =1:t,
            time(i) =i; 
        end
        figure;
        
        for i =1:vars,
            varName = table.Properties.VariableNames{i};
            subplot(vars,1,i);
            plot(time,V(:,i));
            title([ varName]);
        end
        if save_fig,
            nm = ['./figs/transienteval/' md.miscellaneous.name '_basin10_AggregatedValues.fig'];
            savefig(nm);
        end
    end %}}}
    if perform(org,'Plot_aggregated_values_expPIG'),% {{{
        expfile = '../Exp/PigDomain_drwan.exp';
        basinName = md.miscellaneous.name;
        [~, basename, ~] = fileparts(expfile);
        directory = 'Data/Tables';
        filename = fullfile(directory, sprintf('AggregatedValues_%s_Exp_area_%s.csv', basinName, basename));
        table = readtable(filename);
        V =table.Variables;
        [t,vars]= size(table);
        time = zeros(t,1);
        for i =1:t,
            time(i) =i; 
        end
        figure;
        
        for i =1:vars,
            varName = table.Properties.VariableNames{i};
            subplot(vars,1,i);
            plot(time,V(:,i));
            title([ varName]);
        end
        if save_fig,
            nm = ['./figs/transienteval/' md.miscellaneous.name '_EXP_PIG_AggregatedValues.fig'];
            savefig(nm);
        end
    end %}}}
    if perform(org,'Plot_aggregated_values_expTHW'),% {{{
        expfile = '../Exp/THWDomain_drwan.exp';
        basinName = md.miscellaneous.name;
        [~, basename, ~] = fileparts(expfile);
        directory = 'Data/Tables';
        filename = fullfile(directory, sprintf('AggregatedValues_%s_Exp_area_%s.csv', basinName, basename));
        table = readtable(filename);
        V =table.Variables;
        [t,vars]= size(table);
        time = zeros(t,1);
        for i =1:t,
            time(i) =i; 
        end
        figure;
        
        for i =1:vars,
            varName = table.Properties.VariableNames{i};
            subplot(vars,1,i);
            plot(time,V(:,i));
            title([ varName]);
        end
        if save_fig,
            nm = ['./figs/transienteval/' md.miscellaneous.name '_EXP_TWH_AggregatedValues.fig'];
            savefig(nm);
        end
    end %}}}

