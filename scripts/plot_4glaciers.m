function plot_4glaciers(md_in,md_end,figname,save_fig)



    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
    datadir= '/Users/jbec0008/SAEF/datasets/';
    data_smb='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/preprocess/SMB_JOHANNA/';
    data_2km_xy='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/AtmosphericForcing/noresm1-m_rcp8.5/';
    data_ocean='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/Ocean/';
    data_tmp_ocean = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Ocean/';
    data_tmp_smb = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Atmosphere/';
    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');



    sz = size(md_in.results.TransientSolution);
    h0=isoline(md_present,md_present.mask.ocean_levelset,'value',0,'output','matrix');
    hc=isoline(md_present,md_present.mask.ice_levelset,'value',0,'output','matrix');
    
    fl1 = expread('./../Exp/THW_1992.exp');
    fl = expread('./../Exp/PIG_1940.exp');

    CM = jet(sz(2));
    cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
    c_lim=1000;
    C=whiteblue(-c_lim,c_lim);

    pvel = './Models/';

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
    set(gca(),'ColorOrder',cmap)
    for i =1:sz(2),
        name=['historic_from_',num2str(i),md_end];
        save_p= [pvel, name];
        md = loadmodel(save_p);
        hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
        val= i*50;
        hold on; plot(hii(:,1),hii(:,2),'-','Displayname',['from -',num2str(val), 'a'] );
    end
    hold off;
    if save_fig,
        nm = ['./figs/' figname 'PIG.png'];
        saveas(gcf,nm)
    end

    plotmodel(md_present,'figure',2,'visible','off','title','THW', 'data', md_present.geometry.bed,...
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
    set(gca(),'ColorOrder',cmap)
    for i =1:sz(2),
        name=['historic_from_',num2str(i),md_end];
        save_p= [pvel, name];
        md = loadmodel(save_p);
        hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
        val= i*50;
        hold on; plot(hii(:,1),hii(:,2),'-','Displayname',['from -',num2str(val), 'a'] );
    end
    hold off;
    if save_fig,
        nm = ['./figs/' figname 'THW.png'];
        saveas(gcf,nm)
    end

    plotmodel(md_present,'figure',3,'visible','off','title','Totten and Moscow', 'data', md_present.geometry.bed,...
    'colormap',C,...
    'caxis',[-1000,-500],...
    'xlim',[2.1e6,2.4e6],...
    'ylim',[-1.4e6,-1e6])
    h = legend('show','location','southeast');
    set(h,'FontSize',6);
    hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','g.l. present');
    hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
    hold on; plot(fl1.x,fl1.y,'-','Color','red','LineWidth',5,'Displayname','THW-1992');
    hold on; plot(fl.x,fl.y,'-','Color','red','LineWidth',5,'Displayname','PIG-1940');
    % for i =1:2,
    set(gca(),'ColorOrder',cmap)
    for i =1:sz(2),
        name=['historic_from_',num2str(i),md_end];
        save_p= [pvel, name];
        md = loadmodel(save_p);
        hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
        val= i*50;
        hold on; plot(hii(:,1),hii(:,2),'-','Displayname',['from -',num2str(val), ' y'] );

    end
    hold off;
    if save_fig,
       nm = ['./figs/' figname 'TottenMoscow.png'];
       saveas(gca, nm)
    end

