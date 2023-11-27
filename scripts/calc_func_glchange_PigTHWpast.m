function gl_change=calc_func_glchange_PigTHWpast(steps,md_hist)


    % loadonly = 1;
    addpath('./../scripts');



    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
    datadir= '/Users/jbec0008/SAEF/datasets/';
    data_smb='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/preprocess/SMB_JOHANNA/';
    data_2km_xy='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/AtmosphericForcing/noresm1-m_rcp8.5/';
    data_ocean='/Volumes/Crucial X8/SAEF/ISMIP6/data_and_preprocessing/published_data/ISMIP6/Ocean/';
    data_tmp_ocean = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Ocean/';
    data_tmp_smb = '/Users/jbec0008/SAEF/issm_projects/equi_1850/Data/Atmosphere/';
    % loadonly=1;
    % InterpFromMeshToMesh2d
    
    dist_gl = reinitializelevelset(md_hist, md_hist.results.TransientSolution(end).MaskOceanLevelset);    

    % clim runs 10-12
if perform(org,'PIG_1940')% {{{
    fl = expread('./../Exp/PIG_1940.exp');

    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md_hist.mesh.x,md_hist.mesh.y,'./../Exp/PIG_gl.exp',0));
    err_val = -9e10;
    dist_gl(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md_hist, dist_gl, fl, 100);
    m_error = dist <=-9e5; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');

end %}}}
if perform(org,'TWH_1992')% {{{
    fl = expread('./../Exp/THW_1992.exp');

    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md_hist.mesh.x,md_hist.mesh.y,'./../Exp/THW_gl.exp',0));
    err_val = -9e10;
    dist_gl(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md_hist, dist_gl, fl, 100);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');

end %}}}
