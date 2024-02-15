function gl_change=calc_func_glchange_presentday(steps,md_hist,md,dist_gl_presentday,tr_step)
    % md_hist is model iwht transiedn run, last step is used to calculate grounding line thickness
     if ~exist('tr_step','var')
         % third parameter does not exist, so default it to something
          tr_step =size(md_hist.results.TransientSolution,2);

     end


    % loadonly = 1;
    addpath('./../scripts');

    
    data_tmp_smb = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Atmosphere/';
    pth = '/g/data/au88/jb1863/SAEF/ISSM-projects-cluster/';


    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
if perform(org,'PIG_presentday')% {{{

    fl=isoline(md_hist,md_hist.results.TransientSolution(tr_step).MaskOceanLevelset,'value',0,'output','structure');
    % get all avles outoside of PIG and set to zero
    exp_p= [pth '/Exp/PIG_gl.exp'];
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,exp_p,0));
    err_val = -9e10;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));


end %}}}
if perform(org,'THW_presentday')% {{{

    fl=isoline(md_hist,md_hist.results.TransientSolution(tr_step).MaskOceanLevelset,'value',0,'output','structure');
    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/THW_gl.exp',0));
    err_val = -9e10;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));


end %}}}
if perform(org,'Moscow_presentday')% {{{

    fl=isoline(md_hist,md_hist.results.TransientSolution(tr_step).MaskOceanLevelset,'value',0,'output','structure');
    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/Moscow_gl.exp',0));
    err_val = -9e10;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));


end %}}}
if perform(org,'Totten_presentday')% {{{

    fl=isoline(md_hist,md_hist.results.TransientSolution(tr_step).MaskOceanLevelset,'value',0,'output','structure');
    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/Totten_gl.exp',0));
    err_val = -9e10;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));


end %}}}


