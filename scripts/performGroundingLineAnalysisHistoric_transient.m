function gls = performGroundingLineAnalysisHistoric_transient(step,md_hist)
 % Input validation
    if nargin < 2
        error('Not enough input arguments. Please provide steps and md_hist.');
    end

        % If tr_step is not provided, set it to the last step of md_hist
        if isempty(md_hist) || isempty(md_hist.results) || isempty(md_hist.results.TransientSolution)
            error('Invalid md_hist object. Make sure it has the expected structure.');
        end
    if ~isnumeric(step)
        error('step has to be an integer');
    end

    % Check if the number of transient steps is non-positive
    nums = size(md_hist.results.TransientSolution, 2);
    if nums <= 0
        error('Invalid number of transient steps. Ensure that md_hist has valid TransientSolution data.');
    end

    nums =  size(md_hist.results.TransientSolution,2);


    gls =[];
% for i=1 :nums
    for i=1 :1
        gl =calc_func_glchange_PigTHWpast(step,md_hist,i) ;
        gls = [gls gl];
    end

