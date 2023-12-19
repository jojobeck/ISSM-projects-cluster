function gls=calc_func_glchange_PigTHWpast(md_hist,tr_step)

    if nargin < 2
        error('Not enough input arguments. Please provide at least steps, md_hist, md, and dist_gl_presentday.');
    end

    % If tr_step is not provided, set it to the last step of md_hist
    if isempty(md_hist) || isempty(md_hist.results) || isempty(md_hist.results.TransientSolution)
        error('Invalid md_hist object. Make sure it has the expected structure.');
    end
    tr_step = size(md_hist.results.TransientSolution, 2);


    % Check if tr_step is greater than the size of md_hist.results.TransientSolution
    if tr_step > size(md_hist.results.TransientSolution, 2)
        error('Invalid tr_step. It cannot be greater than the number of transient solution steps.');
    end

    % loadonly = 1;
    addpath('./../scripts');



    
    dist_gl = reinitializelevelset(md_hist, md_hist.results.TransientSolution(tr_step).MaskOceanLevelset);    

   gls = zeros(1,2); 
    % clim runs 10-12
    fl = expread('./../Exp/PIG_1940.exp');

    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md_hist.mesh.x,md_hist.mesh.y,'./../Exp/PIG_gl.exp',0));
    err_val = -9e10;
    dist_gl(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md_hist, dist_gl, fl, 100);
    m_error = dist <=-9e5; %acounting for rounding errors
    gl_change =mean(dist(~m_error));
    gls(1,1)=gl_change;


    fl = expread('./../Exp/THW_1992.exp');

    % get all avlues outoside of PIG and set to zero
    posPig=find(~ContourToNodes(md_hist.mesh.x,md_hist.mesh.y,'./../Exp/THW_gl.exp',0));
    err_val = -9e10;
    dist_gl(posPig)=err_val;

    [index, X, Y, Z, S, dist] = SectionValues(md_hist, dist_gl, fl, 100);
    m_error = dist <=-9e8; %acounting for rounding errors
    gl_change =mean(dist(~m_error));
    gls(1,2)=gl_change;

	% md=loadmodel('./Models/ISMIP6Antarctica__CollapseSSA.math');

