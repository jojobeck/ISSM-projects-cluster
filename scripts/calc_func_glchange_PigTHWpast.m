function gl_change=calc_func_glchange_PigTHWpast(steps,md_hist,tr_step)

    if nargin < 2
        error('Not enough input arguments. Please provide at least steps, md_hist, md, and dist_gl_presentday.');
    end

    if nargin < 3
        % If tr_step is not provided, set it to the last step of md_hist
        if isempty(md_hist) || isempty(md_hist.results) || isempty(md_hist.results.TransientSolution)
            error('Invalid md_hist object. Make sure it has the expected structure.');
        end
        tr_step = size(md_hist.results.TransientSolution, 2);
    end

    if ~isnumeric(steps) || ~isnumeric(tr_step)
        error('Invalid input argument types. Please check the input types.');
    end


    % Check if tr_step is greater than the size of md_hist.results.TransientSolution
    if tr_step > size(md_hist.results.TransientSolution, 2)
        error('Invalid tr_step. It cannot be greater than the number of transient solution steps.');
    end

    % loadonly = 1;
    addpath('./../scripts');



    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;

    % loadonly=1;
    % InterpFromMeshToMesh2d
    
    dist_gl = reinitializelevelset(md_hist, md_hist.results.TransientSolution(tr_step).MaskOceanLevelset);    

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
