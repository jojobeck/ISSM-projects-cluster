function results =ananlyze_hist2_exp_oceanPIG95percentile(name);
    % Creates tablewith the minimum distance to the historic and  p.d. gorunding lines in allowed time window with indices of array.
    % creates weights and order with in the experiment for the best to worse runo
    % lists the best and worse models with the indice of the first table
    name_save = ['./Data/Tables/analysisRuns_hist2_oceanPIG95percentile_' name '_withparalell.mat'];
    % name_save = ['./Data/Tables/analysisResults_withparalell.mat'];
    experiment = load(name_save);
    numRuns = size(experiment.results,2);
    dist_PIG_pd_all = [];
    dist_THW_pd_all = [];
    dist_Moscow_pd_all = [];
    dist_Totten_pd_all = [];
    dist_to_PIG1940_all = [];
    dist_to_THW1992_all = [];
    time_dist_PIG_pd_all = [];
    time_dist_THW_pd_all = [];
    time_dist_Moscow_pd_all = [];
    time_dist_Totten_pd_all = [];
    time_dist_to_PIG1940_all = [];
    time_dist_to_THW1992_all = [];
    grad_AIS_all =[];
    grad_PIG_all =[];
    grad_TOTTEN_all =[];
    time_grad_AIS_all =[];
    time_grad_PIG_all =[];
    time_grad_TOTTEN_all =[];
    model_names = [];
    for i=1:numRuns
        if ~isempty(experiment.results(i).data)
            %historic G.l. postive means still advanced negative already retreated thereofr multipli by -1!
            dist_to_PIG1940=min(abs(experiment.results(i).data.groundinglineDistance_hist.groundingLineDistance_PIGto1940));
            time_dist_to_PIG1940= find(abs(experiment.results(i).data.groundinglineDistance_hist.groundingLineDistance_PIGto1940)==dist_to_PIG1940,1,'first');
            dist_to_PIG1940=-1* experiment.results(i).data.groundinglineDistance_hist.groundingLineDistance_PIGto1940(time_dist_to_PIG1940);
            dist_to_PIG1940_all = [dist_to_PIG1940_all ; dist_to_PIG1940];
            time_dist_to_PIG1940_all = [time_dist_to_PIG1940_all ; time_dist_to_PIG1940];

            dist_to_THW1992 = min(abs(experiment.results(i).data.groundinglineDistance_hist.groundingLineDistance_THWto1922));
            time_dist_to_THW1992 = find(abs(experiment.results(i).data.groundinglineDistance_hist.groundingLineDistance_THWto1922)==dist_to_THW1992,1,'first');
            dist_to_THW1992 = -1*experiment.results(i).data.groundinglineDistance_hist.groundingLineDistance_THWto1922(time_dist_to_THW1992);
            dist_to_THW1992_all = [dist_to_THW1992_all ; dist_to_THW1992];
            time_dist_to_THW1992_all = [time_dist_to_THW1992_all ; time_dist_to_THW1992];
            
            % Present day gl. negative means g.l is still advanced, postive already retretaed  p.d.g.l.
            j=1;
            A = min(abs(experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(:,j)));
            time_dist_PIG_pd = find(abs(experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(:,j)) == A,1,'first');
            dist_PIG_pd = experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(time_dist_PIG_pd,j);
            dist_PIG_pd_all = [dist_PIG_pd_all ; dist_PIG_pd];
            time_dist_PIG_pd_all = [time_dist_PIG_pd_all ; time_dist_PIG_pd];

            j=2;%for Thw
            A = min(abs(experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(:,j)));
            time_dist_THW_pd = find(abs(experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(:,j)) == A,1,'first');
            dist_THW_pd = experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(time_dist_THW_pd,j);
            dist_THW_pd_all = [dist_THW_pd_all ; dist_THW_pd];
            time_dist_THW_pd_all = [time_dist_THW_pd_all ; time_dist_THW_pd];

            j=3;
            A = min(abs(experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(:,j)));
            time_dist_Moscow_pd = find(abs(experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(:,j)) == A,1,'first');
            dist_Moscow_pd = experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(time_dist_Moscow_pd,j); 
            dist_Moscow_pd_all = [dist_Moscow_pd_all ; dist_Moscow_pd];
            time_dist_Moscow_pd_all = [time_dist_Moscow_pd_all ; time_dist_Moscow_pd];

            j=4;%for Totten
            A = min(abs(experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(:,j)));
            time_dist_Totten_pd = find(abs(experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(:,j)) == A,1,'first');
            dist_Totten_pd = experiment.results(i).data.groundinglineDistance_pd.groundingLineDistance_alltransient(time_dist_Totten_pd,j);
            dist_Totten_pd_all = [dist_Totten_pd_all ; dist_Totten_pd];
            time_dist_Totten_pd_all = [time_dist_Totten_pd_all ; time_dist_Totten_pd];
            
            model_names =[model_names ;i];

            A =min(experiment.results(i).data.rmseThicknessGradient.rmse_AIS);
            time_grad_AIS=find(experiment.results(i).data.rmseThicknessGradient.rmse_AIS == A,1,'first');
            grad_AIS_all =[grad_AIS_all; A];
            time_grad_AIS_all =[time_grad_AIS_all; time_grad_AIS];

            A =min(experiment.results(i).data.rmseThicknessGradient.rmse_PIG);
            time_grad_PIG=find(experiment.results(i).data.rmseThicknessGradient.rmse_PIG == A,1,'first');
            grad_PIG_all =[grad_PIG_all; A];
            time_grad_PIG_all =[time_grad_PIG_all; time_grad_PIG];

            A =min(experiment.results(i).data.rmseThicknessGradient.rmse_TOTTEN);
            time_grad_TOTTEN=find(experiment.results(i).data.rmseThicknessGradient.rmse_TOTTEN == A,1,'first');
            grad_TOTTEN_all =[grad_TOTTEN_all; A];
            time_grad_TOTTEN_all =[time_grad_TOTTEN_all; time_grad_TOTTEN];
        end 
    end
    T = table(model_names,dist_to_PIG1940_all,dist_to_THW1992_all,dist_PIG_pd_all,dist_THW_pd_all,dist_Moscow_pd_all,dist_Totten_pd_all,grad_AIS_all,grad_PIG_all,grad_TOTTEN_all); 
    parts = strsplit(name, 'from_');
    parts2 =strsplit(parts{2},'_SMB4x.txt');
    namo = parts2{1};
    name_table = ['./Data/Tables/','min_distance_hist2_runs_oceanPIG95percnetile_' namo '.txt'];
    writetable(T, name_table) ;

    Ttime = table(model_names,time_dist_to_PIG1940_all,time_dist_to_THW1992_all,time_dist_PIG_pd_all,time_dist_THW_pd_all,time_dist_Moscow_pd_all,time_dist_Totten_pd_all,time_grad_AIS_all,time_grad_PIG_all,time_grad_TOTTEN_all); 
    name_table = ['./Data/Tables/','time_min_distance_hist2_runs_oceanPIG95percentile_' namo '.txt'];
    writetable(Ttime, name_table) ;
    T_scaled =T;
    for i=2: size(T,2)
        T_scaled(:,i).Variables =T_scaled(:,i).Variables/median(T_scaled(:,i).Variables);
    end
    T_scaled.equal_weight=prod(T_scaled{:, 2:end}, 2); 
    name_table = ['./Data/Tables/','weighted_within_exptype_oceanPIG95percentile_' namo '.txt'];
    writetable(T_scaled, name_table) ;
    [sortedArray, indices] = sort(T_scaled.equal_weight);
    p_table = 'Data/Tables/';
    namenew = [p_table 'cond_hist1_' name];
    Trun = readtable(namenew, 'Delimiter' , ','); 
    T_order =Trun;
    T_order = T_order(indices, :);
    T_order.indices =indices;
    name_table = ['./Data/Tables/','orderd_experiments_weighted_within_exptype_oceanPIG95percentile_' namo '.txt'];
    writetable(T_order, name_table);


