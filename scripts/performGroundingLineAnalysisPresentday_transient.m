function gls = performGroundingLineAnalysisPresentday_transient(step,md_hist,md_present,dist_gl_presentday)
    % Perform grounding line analysis for present day transient solutions

    % Input validation
    if nargin < 4
        error('Not enough input arguments. Please provide step, md_hist, and md_present.');
    end

    % Check if step is a positive integer
    if ~isnumeric(step) || ~isscalar(step) || step < 1 || mod(step, 1) ~= 0
        error('Invalid input type or value for step. Please provide a positive integer.');
    end

    % Check if md_hist and md_present are instances of the 'model' class
    if ~isa(md_hist, 'model') || ~isa(md_present, 'model')
        error('Invalid model objects. Please provide instances of the ''model'' class.');
    end

    % Check if md_hist has valid TransientSolution data
    if isempty(md_hist.results.TransientSolution)
        error('Invalid md_hist object. Missing or empty TransientSolution field in results.');
    end


    % Calculate the number of transient steps
    nums = size(md_hist.results.TransientSolution, 2);
    % Initialize the grounding line array
    % gls = [];
    gls =zeros(1,nums);


    % Loop through each transient step
    % for i = 1:nums
    for i = 1:1
        % Call calc_func_glchange_presentday function (assuming it's defined elsewhere)
        gls(i)= calc_func_glchange_presentday(step, md_hist, md_present, dist_gl_presentday, i);

        % Append the result to the grounding line array
        % gls = [gls, gl];
    end
end
