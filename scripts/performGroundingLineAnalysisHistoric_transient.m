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
    if nums <= 70
        error('Invalid number of transient steps. Ensure that md_hist has valid TransientSolution data.');
    end

    nums =  size(md_hist.results.TransientSolution,2);


    if step ==1%only wnat values form 1931-1970 for pig
        gls =zeros(1,40);
        for i=1 :40
            gls(1,i) =calc_func_glchange_PigTHWpast(step,md_hist,i) ;
        end
    end

    if step ==2
        gls =zeros(1,10);
        for i=60 :70
            gls(1,i-59) =calc_func_glchange_PigTHWpast(step,md_hist,i) ;
        end
    end
