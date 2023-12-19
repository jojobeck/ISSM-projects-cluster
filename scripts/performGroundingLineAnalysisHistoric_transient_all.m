function gls = performGroundingLineAnalysisHistoric_transient_all(md_hist)
 % Input validation
    if nargin < 1
        error('Not enough input arguments. Please provide steps and md_hist.');
    end

        % If tr_step is not provided, set it to the last step of md_hist
    if isempty(md_hist) || isempty(md_hist.results) || isempty(md_hist.results.TransientSolution)
        error('Invalid md_hist object. Make sure it has the expected structure.');
    end

    % Check if the number of transient steps is non-positive
    nums = size(md_hist.results.TransientSolution, 2);
    if nums <= 0
        error('Invalid number of transient steps. Ensure that md_hist has valid TransientSolution data.');
    end

    nums =  size(md_hist.results.TransientSolution,2);


    gls = zeros(nums,2);
    % for i=1 :nums
    for i=1 :1
        gl = ones(1,2);
        % gls(i,:) = gl;
        gls(i,:) =calc_struc_glchange_PigTHWpast(md_hist,i) ;
    end
