function results =ananlyze_hist2_exp_parallel(name,numberofworkers);
    if ~exist('numberOfWorksers','var')
      numberOfWorkers= 1;
    end
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
    parfor(i = 1:numRuns, numberOfWorkers)
        runName=['hist2_' T.model_names{runIndex}];
        model_pth = ['Models/' runName];
        %loadmodel 
        md_hist = loadmodel(model_pth);
        % Initialize a structure for each run
        runStruct = struct();
        gls = struct();
        glsPig = cell(1,numRuns);
        glsThw = cell(1,numRuns);
        glsPig1940 = cell(1,numRuns);
        glsThw1993 = cell(1,numRuns);
        glsTotten = cell(1,numRuns);
        glsMoscow = cell(1,numRuns);
        glhistStruct = struct();


        % Loop through each output data set
        % Perform analysis and store the result in the structure
        glsPig{i}=performGroundingLineAnalysisPresentday_transient(1,md_hist,md_present);  % give distance to present day gl each timestep
        glsThw{i}= performGroundingLineAnalysisPresentday_transient(2,md_hist,md_present);
        glsMoscow{i}=performGroundingLineAnalysisPresentday_transient(3,md_hist,md_present);
        glsTotten{i}= performGroundingLineAnalysisPresentday_transient(4,md_hist,md_present);
        %hisitoric distance
        glsPig1940{i}=performGroundingLineAnalysisHistoric_transient(1,md_hist);
        glsThw1993{i}=performGroundingLineAnalysisHistoric_transient(2,md_hist);
        % comp smith et al.
        rmseThicknessGradient{i} = performRMSEAnalysis_transient(3,md_hist,md_present);  % gives sructure of RMSE to smihr dhdt

% Store the results in the structure
% runStruct.groundinglineDistance_pd =  glpdStruc;
% runStruct.groundinglineDistance_hist =  glhistStruct;

% runStruct.rmseThicknessGradient = rmseThicknessGradient_struc;

% Store the run structure in the results array
% results(runIndex).run = runName;
% results(runIndex).data = runStruct;
    end

    save('./Data/Tables/analysisResults.mat', 'results');

