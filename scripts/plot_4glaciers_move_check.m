function plot_4glaciers_clim(md,md_present,figname,save_fig)
   




    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;



    sz = size(md.results.TransientSolution);
    h0=isoline(md_present,md_present.mask.ocean_levelset,'value',0,'output','matrix');
    hc=isoline(md_present,md_present.mask.ice_levelset,'value',0,'output','matrix');
    
    fl1 = expread('./../Exp/THW_1992.exp');
    fl = expread('./../Exp/PIG_1940.exp');

    CM = jet(floor(sz(2)/5));
    cmap = flip(autumn(floor(sz(2)/5)+1),1); % yellow -> red, with 61 colors (for 61 lines)
    c_lim=1000;
    C=whiteblue(-c_lim,c_lim);

    pvel = './Models/';
    i_1992=62;
    i_1940=10;
    plotmodel(md_present,'figure',1,'visible','off','title','PIG', 'data', md_present.geometry.bed,...
    'colormap',C,...
    'caxis',[-1000,-500],...
    'xlim',[-1.7e6,-1.5e6],...
    'ylim',[-3.8e5,-2e5])
    h = legend('show','location','east');
    set(h,'FontSize',8);
    hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','g.l. present');
    hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
    hold on; plot(fl1.x,fl1.y,'-','Color','red','LineWidth',5,'Displayname','THW-1992');
    hold on; plot(fl.x,fl.y,'-','Color','red','LineWidth',5,'Displayname','PIG-1940');
    set(gca(),'ColorOrder',cmap);
    hii=isoline(md,md.results.TransientSolution(1).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
    hold on; plot(hii(:,1),hii(:,2),'--','Displayname','1850 position' );
    hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
    hold on; plot(hii(:,1),hii(:,2),'-','Displayname','1930 position' );
    if save_fig,
        nm = ['./figs/' figname 'PIG_hist1.png'];
        saveas(gcf,nm);
    end
    plotmodel(md_present,'figure',2,'visible','off','title','Thwaites', 'data', md_present.geometry.bed,...
    'colormap',C,...
    'caxis',[-1000,-500],...
    'xlim',[-1.62e6,-1.48e6],...
    'ylim',[-4.9e5,-3.9e5])
    h = legend('show','location','east');
    set(h,'FontSize',8);
    hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','g.l. present');
    hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
    hold on; plot(fl1.x,fl1.y,'-','Color','red','LineWidth',5,'Displayname','THW-1992');
    hold on; plot(fl.x,fl.y,'-','Color','red','LineWidth',5,'Displayname','PIG-1940');
    set(gca(),'ColorOrder',cmap);
    hii=isoline(md,md.results.TransientSolution(1).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
    hold on; plot(hii(:,1),hii(:,2),'--','Displayname','1850 position' );
    hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
    hold on; plot(hii(:,1),hii(:,2),'-','Displayname','1930 position' );

    hold off;
    if save_fig,
        nm = ['./figs/' figname 'THW_hist1.png'];
        saveas(gcf,nm);
    end

    plotmodel(md_present,'figure',3,'visible','off','title','Totten & Moscow University', 'data', md_present.geometry.bed,...
    'colormap',C,...
    'caxis',[-1000,-500],...
    'xlim',[2.1e6,2.4e6],...
    'ylim',[-1.4e6,-1e6])
    h = legend('show','location','east');
    set(h,'FontSize',8);
    hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','g.l. present');
    hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
    hold on; plot(fl1.x,fl1.y,'-','Color','red','LineWidth',5,'Displayname','THW-1992');
    hold on; plot(fl.x,fl.y,'-','Color','red','LineWidth',5,'Displayname','PIG-1940');
    set(gca(),'ColorOrder',cmap);
    hii=isoline(md,md.results.TransientSolution(1).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
    hold on; plot(hii(:,1),hii(:,2),'--','Displayname','1850 position' );
    hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
    hold on; plot(hii(:,1),hii(:,2),'-','Displayname','1930 position' );

    hold off;
    if save_fig,
        nm = ['./figs/' figname 'TOTTEN_hist1.png'];
        saveas(gcf,nm);
    end
