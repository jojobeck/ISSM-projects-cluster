function results = analyze_hist2_exp_parallel(name, numberOfWorkers)
    % Analyze historical experiment data in parallel
    
    % Input validation
    if nargin < 2
        numberOfWorkers = 1;
    end
    
    % Check if numberOfWorkers is a positive integer
    if ~isnumeric(numberOfWorkers) || ~isscalar(numberOfWorkers) || numberOfWorkers < 1 || mod(numberOfWorkers, 1) ~= 0
        error('Invalid input type or value for numberOfWorkers. Please provide a positive integer.');
    end
    
    addpath('./../scripts');
    
    p_table = 'Data/Tables/';
    namenew = [p_table 'cond_hist1_' name];
    T = readtable(namenew, 'Delimiter', ',');
    
    numRuns = size(T, 1);
    
    % Initialize a cell array to store results
    results = cell(1, numRuns);
    
    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');
    
    % Loop through each run in parallel
    parfor i = 1:numRuns
        runName = ['hist2_' T.model_names{i}];
        model_pth = ['Models/' runName];
        
        md_hist = loadmodel(model_pth);
        
        % Initialize a structure for each run
        runStruct = struct();
        
        % Perform analysis and store the result in the structure
        runStruct.groundingLineDistance_PIG = performGroundingLineAnalysisPresentday_transient(1, md_hist, md_present);
        runStruct.groundingLineDistance_THW = performGroundingLineAnalysisPresentday_transient(2, md_hist, md_present);
        runStruct.groundingLineDistance_Moscow = performGroundingLineAnalysisPresentday_transient(3, md_hist, md_present);
        runStruct.groundingLineDistance_Totten = performGroundingLineAnalysisPresentday_transient(4, md_hist, md_present);
        runStruct.groundingLineDistance_PIGto1940 = performGroundingLineAnalysisHistoric_transient(1, md_hist);
        runStruct.groundingLineDistance_THWto1922 = performGroundingLineAnalysisHistoric_transient(2, md_hist);
        runStruct.rmseThicknessGradient = performRMSEAnalysis_transient(3, md_hist, md_present);
        
        % Store the run structure in the results array
        results{i} = struct('run', runName, 'data', runStruct);
    end
    
    % Save the results to a file
    save('./Data/Tables/analysisResults.mat', 'results');
end

