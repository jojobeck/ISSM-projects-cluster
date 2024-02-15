function gl=calc_func_glchange_presentday_all(md_hist,md,dist_gl_presentday_input,tr_step)

    % loadonly = 1;
    addpath('./../scripts');

    
    data_tmp_smb = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Atmosphere/';
    pth = '/g/data/au88/jb1863/SAEF/ISSM-projects-cluster/';


    gl =zeros(1,4);

    fl=isoline(md_hist,md_hist.results.TransientSolution(tr_step).MaskOceanLevelset,'value',0,'output','structure');
    err_val = -9e10;

    exp_p= [pth '/Exp/PIG_gl.exp'];
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,exp_p,0));
    dist_gl_presentday =dist_gl_presentday_input;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

    gl(1,1) =gl_change;


    dist_gl_presentday =dist_gl_presentday_input;
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/THW_gl.exp',0));
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

    gl(1,2) =gl_change;


    dist_gl_presentday =dist_gl_presentday_input;
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/Moscow_gl.exp',0));
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

    gl(1,3) =gl_change;


    dist_gl_presentday =dist_gl_presentday_input;

    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/Totten_gl.exp',0));
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

    gl(1,4) =gl_change;



