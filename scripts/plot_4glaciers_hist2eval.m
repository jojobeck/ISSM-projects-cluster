function plot_4glaciers(md,i_best,figname,save_fig)



    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');



    sz = size(md.results.TransientSolution);
    h0=isoline(md_present,md_present.mask.ocean_levelset,'value',0,'output','matrix');
    hc=isoline(md_present,md_present.mask.ice_levelset,'value',0,'output','matrix');
    
    fl1 = expread('./../Exp/THW_1992.exp');
    fl = expread('./../Exp/PIG_1940.exp');

    CM = jet(floor(sz(2)/5));
    cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
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
% disp(sz(2));
    for i =1:5:sz(2),
% disp(i);
        hii=isoline(md,md.results.TransientSolution(i).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
        val= i+1930;
        hold on; plot(hii(:,1),hii(:,2),'-','Displayname',[num2str(val)] );
    end
    hold off;
    if save_fig,
        nm = ['./figs/' figname 'PIG_hist2.png'];
        saveas(gcf,nm);
    end

% plotmodel(md_present,'figure',2,'visible','off','title','THW', 'data', md_present.geometry.bed,...
% 'colormap',C,...
% 'caxis',[-1000,-500],...
% 'xlim',[-1.62e6,-1.48e6],...
% 'ylim',[-4.9e5,-3.9e5])
% h = legend('show','location','east');
% set(h,'FontSize',8);
% hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','g.l. present');
% hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
% hold on; plot(fl1.x,fl1.y,'-','Color','red','LineWidth',5,'Displayname','THW-1992');
% hold on; plot(fl.x,fl.y,'-','Color','red','LineWidth',5,'Displayname','PIG-1940');
% set(gca(),'ColorOrder',cmap)
% for i =1:5:sz(2),
% name=['historic_from_',num2str(i),md_end];
% save_p= [pvel, name];
% md = loadmodel(save_p);
% hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
% val= i*5;
% hold on; plot(hii(:,1),hii(:,2),'-','Displayname',['from -',num2str(val), 'a'] );
% end
% hold off;
% if save_fig,
% nm = ['./figs/' figname 'THW.png'];
% saveas(gcf,nm)
% end

% plotmodel(md_present,'figure',3,'visible','off','title','Totten and Moscow', 'data', md_present.geometry.bed,...
% 'colormap',C,...
% 'caxis',[-1000,-500],...
% 'xlim',[2.1e6,2.4e6],...
% 'ylim',[-1.4e6,-1e6])
% h = legend('show','location','southeast');
% set(h,'FontSize',6);
% hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','g.l. present');
% hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
% hold on; plot(fl1.x,fl1.y,'-','Color','red','LineWidth',5,'Displayname','THW-1992');
% hold on; plot(fl.x,fl.y,'-','Color','red','LineWidth',5,'Displayname','PIG-1940');
% set(gca(),'ColorOrder',cmap)
% for i =1:5:sz(2),
% name=['historic_from_',num2str(i),md_end];
% save_p= [pvel, name];
% md = loadmodel(save_p);
% hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
% val= i*5;
% hold on; plot(hii(:,1),hii(:,2),'-','Displayname',['from -',num2str(val), ' y'] );

% end
% hold off;
% if save_fig,
% nm = ['./figs/' figname 'TottenMoscow.png'];
% saveas(gca, nm)
% end

