function gl_change=calc_func_glchange_presentday(steps,md_hist,md,dist_gl_presentday,tr_step)

 % Input validation
    if nargin < 4
        error('Not enough input arguments. Please provide at least steps, md_hist, md, and dist_gl_presentday.');
    end

    if nargin < 5
        % If tr_step is not provided, set it to the last step of md_hist
        if isempty(md_hist) || isempty(md_hist.results) || isempty(md_hist.results.TransientSolution)
            error('Invalid md_hist object. Make sure it has the expected structure.');
        end
        tr_step = size(md_hist.results.TransientSolution, 2);
    end

    if ~isnumeric(steps) || ~isobject(md) || ~isnumeric(dist_gl_presentday) || ~isnumeric(tr_step)
        error('Invalid input argument types. Please check the input types.');
    end


    % Check if tr_step is greater than the size of md_hist.results.TransientSolution
    if tr_step > size(md_hist.results.TransientSolution, 2)
        error('Invalid tr_step. It cannot be greater than the number of transient solution steps.');
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


