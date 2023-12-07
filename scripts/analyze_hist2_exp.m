function results =ananlyze_hist2_exp(name);
    addpath('./../scripts');
    p_table = 'Data/Tables/';
    namenew = [p_table 'cond_hist1_' name];
    T = readtable(namenew, 'Delimiter' , ',');
    % Number of runs and output data sets
    numRuns = size(T,1);

    % Initialize a structure array to store results
    results = struct('run', cell(1, numRuns), 'data', cell(1, numRuns));

    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');
    % Reinitialize level set for present day
    dist_gl_presentday = reinitializelevelset(md_present, md_present.mask.ocean_levelset);
    % Loop through each run
    for runIndex = 1:numRuns
        runName=['hist2_' T.model_names{runIndex}];
        model_pth = ['Models/' runName];
        %loadmodel 
        md_hist = loadmodel(model_pth);
        % Initialize a structure for each run
        runStruct = struct();
        glpdStruc = struct();
        glhistStruct = struct();


        % Loop through each output data set
        %hisitoric distance
        glhistStruct.groundingLineDistance_PIGto1940=performGroundingLineAnalysisHistoric_transient(1,md_hist);
        glhistStruct.groundingLineDistance_THWto1922=performGroundingLineAnalysisHistoric_transient(2,md_hist);
        % glhistStruct.groundingLineDistance_PIGto1940=performGroundingLineAnalysisHistoric_transient_all(md_hist);
        % comp smith et al.
        rmseThicknessGradient_struc = performRMSEAnalysis_transient(3,md_hist,md_present);  % gives sructure of RMSE to smihr dhdt

        % Store the results in the structure
        
        glpdStruc.groundingLineDistance_alltransient = performGroundingLineAnalysisPresentday_transientall(md_hist,md_present,dist_gl_presentday);  % give distance to present day gl each timestep
        runStruct.groundinglineDistance_pd =  glpdStruc;
        runStruct.groundinglineDistance_hist =  glhistStruct;

        runStruct.rmseThicknessGradient = rmseThicknessGradient_struc;

        % Store the run structure in the results array
        results(runIndex).run = runName;
        results(runIndex).data = runStruct;
    end

    % Save the results to a file if needed
    name_save = ['./Data/Tables/analysisRuns_hist2_' name '_withparalell.mat'];
    save(name_save, 'results');

