function gls = performGroundingLineAnalysisPresentday_transientall(md_hist,md_present,dist_gl_presentday)
    % Perform grounding line analysis for present day transient solutions

    % Calculate the number of transient steps
    nums = size(md_hist.results.TransientSolution, 2);
    % Initialize the grounding line array
    gls = zeros(20,4);

    % Reinitialize level set for present day

% Loop through each transient step
    for i = 80:100
        gls(i-79,:) = calc_func_glchange_presentday_all( md_hist, md_present, dist_gl_presentday,i);
    % gl = ones(1,4);


    % Append the result to the grounding line array
    % gls(i,:) =  gl;
    end
