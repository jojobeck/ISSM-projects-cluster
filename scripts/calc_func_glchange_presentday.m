function gl_change=calc_func_glchange_presentday(steps,md_hist,md,dist_gl_presentday)
    % md_hist is model iwht transiedn run, last step is used to calculate grounding line thickness
    if ~exist('md_present','var')
     % loadonly parameter does not exist, so default it to something
      % md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');
    end


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
    
    % dist_gl_presentday = reinitializelevelset(md_present, md_present.mask.ocean_levelset);    

    % clim runs 10-12
if perform(org,'PIG_presentday')% {{{
    % gl_name = ['./Data/',md.miscellaneous.name,'_gl.exp'];
    % h0=isoline(md_hist,md_hist.md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output',gl_name);
    % fl = expread(fullfile(gl_name));

    fl=isoline(md_hist,md_hist.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','structure');
    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/PIG_gl.exp',0));
    err_val = -9e10;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');

end %}}}
if perform(org,'THW_presentday')% {{{
    % gl_name = ['./Data/',md.miscellaneous.name,'_gl.exp'];
    % h0=isoline(md_hist,md_hist.md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output',gl_name);
    % fl = expread(fullfile(gl_name));

    fl=isoline(md_hist,md_hist.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','structure');
    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/THW_gl.exp',0));
    err_val = -9e10;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');

end %}}}
if perform(org,'Moscow_presentday')% {{{
    % gl_name = ['./Data/',md.miscellaneous.name,'_gl.exp'];
    % h0=isoline(md_hist,md_hist.md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output',gl_name);
    % fl = expread(fullfile(gl_name));

    fl=isoline(md_hist,md_hist.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','structure');
    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/Moscow_gl.exp',0));
    err_val = -9e10;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');

end %}}}
if perform(org,'Totten_presentday')% {{{
    % gl_name = ['./Data/',md.miscellaneous.name,'_gl.exp'];
    % h0=isoline(md_hist,md_hist.md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output',gl_name);
    % fl = expread(fullfile(gl_name));

    fl=isoline(md_hist,md_hist.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','structure');
    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md.mesh.x,md.mesh.y,'./../Exp/Totten_gl.exp',0));
    err_val = -9e10;
    dist_gl_presentday(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md, dist_gl_presentday, fl, 1000);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');

end %}}}


