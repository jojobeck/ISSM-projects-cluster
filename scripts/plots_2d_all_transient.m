function plot_2d_all_transient(md,figname,save_fig);
    sz = size(md.results.TransientSolution);
    diff_sim = md.results.TransientSolution(end).Vel-md.results.TransientSolution(1).Vel;

    diff_sim_H = md.results.TransientSolution(end).Thickness-md.results.TransientSolution(1).Thickness;                                                                                                                                   
    diff_sim_bm = md.results.TransientSolution(end).BasalforcingsFloatingiceMeltingRate-md.results.TransientSolution(1).BasalforcingsFloatingiceMeltingRate;
    bz =md.results.TransientSolution(end).BasalforcingsFloatingiceMeltingRate;
    if sz(2)>20,
        disp('take 10 year avg');
        ba=md.results.TransientSolution(1).BasalforcingsFloatingiceMeltingRate;
        for i=1:9,
            ba =ba +md.results.TransientSolution(i+1).BasalforcingsFloatingiceMeltingRate
            bz = bz+md.results.TransientSolution(end-i).BasalforcingsFloatingiceMeltingRate
        end
        ba = ba/10;
        bz = bz/10;
        diff_sim_bm = bz -ba;
        titbm = '10year avg';
    else

        diff_sim_bm = md.results.TransientSolution(end).BasalforcingsFloatingiceMeltingRate-md.results.TransientSolution(1).BasalforcingsFloatingiceMeltingRate;
        titbm = '1year avg';
    end

    pos=md.mask.ice_levelset<0; %ice only
    pos_float= md.mask.ocean_levelset<0;
    pos_grouned=pos & pos_float; %only floaating shelves with ice
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


    tit2 = ['modelled last y -1. velocity'];
    fl1 = expread('./../Exp/PIG_fl_drawn.exp');
    fl2 = expread('./../Exp/THW_fl_drawn.exp');

    figure

    plotmodel(md,...
        'data',diff_sim,'mask',pos,'title',tit2,...
        'data',abs(diff_sim),'mask',pos,'title','abs(vel-diff) modelled yend -y0',...
        'data',diff_sim_H,'mask',pos,'title','thickness y end - 1y0',...
        'data',diff_sim_bm,'mask',pos_grouned,'title',titbm,...
        'data',bz,'mask',pos_grouned,'title','basal melt y end ',...
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
        nm = ['./figs/transienteval/' figname '2dVel.fig'];
        savefig(nm);                                                                                                                                                                                                                      
    end

