% x = 0:pi/100:2*pi;
% y = sin(x);

% f = figure('visible','off');
% plot(x,y);
% saveas(f,'figtest','png');
addpath('./../scripts');
md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');
% dist_gl_presentday = reinitializelevelset(md_present, md_present.mask.ocean_levelset);
h0=isoline(md_present,md_present.mask.ocean_levelset,'value',0,'output','matrix');
hc=isoline(md_present,md_present.mask.ice_levelset,'value',0,'output','matrix');

fl1 = expread('./../Exp/THW_1992.exp');
fl = expread('./../Exp/PIG_1940.exp');

md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');
sz = size(md_in.results.TransientSolution);
CM = jet(sz(2));
cmap = flip(autumn(sz(2)+1),1); % yellow -> red, with 61 colors (for 61 lines)
c_lim=1000;
C=whiteblue(-c_lim,c_lim);

plotmodel(md_present,'figure',1,'visible','off','title','PIG', 'data', md_present.geometry.bed,...
'colormap',C,...
'caxis',[-1000,-500],...
'xlim',[-1.7e6,-1.5e6],...
'ylim',[-3.8e5,-2e5])
h = legend('show','location','east');
set(h,'FontSize',10);
hold on; plot(h0(:,1),h0(:,2),'-','Color','black','LineWidth',5,'Displayname','g.l. present');
hold on; plot(hc(:,1),hc(:,2),'--','Color','green','LineWidth',5,'Displayname','icefront');
hold on; plot(fl1.x,fl1.y,'-','Color','red','LineWidth',5,'Displayname','THW-1992');
hold on; plot(fl.x,fl.y,'-','Color','red','LineWidth',5,'Displayname','PIG-1940');
set(gca(),'ColorOrder',cmap)
for i =1:sz(2),
    name=['historic_from_',num2str(i),'_-1930_from_2ka_PISM_submit.mat'];
    pvel = './Models/';
    save_p= [pvel, name];
    md = loadmodel(save_p);
    hii=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','matrix','Displayname',i);
    val= i*50;
    hold on; plot(hii(:,1),hii(:,2),'-','Displayname',['from -',num2str(val), ' years'] );

end
hold off;
nm = ['./figs/' md_in.miscellaneous.name 'PIG.png'];

saveas(gcf,nm)  
