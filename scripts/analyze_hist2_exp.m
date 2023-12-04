function results =ananlyze_hist2_exp(name);
    addpath('./../scripts');
    p_table = 'Data/Tables/';
    namenew = [p_table 'cond_hist1_' name];
    T = readtable(namenew, 'Delimiter' , ',');
    % Number of runs and output data sets
    numRuns = size(T,1);
    numDataSets = 101;

    % Initialize a structure array to store results
    results = struct('run', cell(1, numRuns), 'data', cell(1, numRuns));

    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');
    % Loop through each run
    % for runIndex = 1:numRuns
    for runIndex = 1:1
        runName=['hist2_' T.model_names{runIndex}];
        model_pth = ['Models/' runName];
        %loadmodel 
        md_hist = loadmodel(model_pth);
        % Initialize a structure for each run
        runStruct = struct();
        glpdStruc = struct();
        glhistStruct = struct();


        % Loop through each output data set
        % Perform analysis and store the result in the structure
        glpdStruc.groundingLineDistance_PIGtransient = performGroundingLineAnalysisPresentday_transient(1,md_hist,md_present);  % give distance to present day gl each timestep
        glpdStruc.groundingLineDistance_THWtransient = performGroundingLineAnalysisPresentday_transient(2,md_hist,md_present);
        glpdStruc.groundingLineDistance_Moscowtransient =performGroundingLineAnalysisPresentday_transient(3,md_hist,md_present);
        glpdStruc.groundingLineDistance_Tottentransient = performGroundingLineAnalysisPresentday_transient(4,md_hist,md_present);
        %hisitoric distance
        glhistStruct.groundingLineDistance_PIGto1940=performGroundingLineAnalysisHistoric_transient(1,md_hist);
        glhistStruct.groundingLineDistance_THWto1922=performGroundingLineAnalysisHistoric_transient(2,md_hist);
        % comp smith et al.
        rmseThicknessGradient_struc = performRMSEAnalysis_transient(3,md_hist,md_present);  % gives sructure of RMSE to smihr dhdt

        % Store the results in the structure
        runStruct.groundinglineDistance_pd =  glpdStruc;
        runStruct.groundinglineDistance_hist =  glhistStruct;

        runStruct.rmseThicknessGradient = rmseThicknessGradient_struc;

        % Store the run structure in the results array
        results(runIndex).run = runName;
        results(runIndex).data = runStruct;
    end

    % Save the results to a file if needed
    save('./Data/Tables/analysisResults.mat', 'results');

