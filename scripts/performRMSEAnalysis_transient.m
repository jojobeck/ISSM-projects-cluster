function RMSEstruc = performRMSEAnalysis_transient(steps,md_hist,md_present)
    % Perform RMSE analysis for transient solutions

    % Input validation
    if nargin < 3
        error('Not enough input arguments. Please provide steps, md_hist, and md_present.');
    end

    % Check if md_hist and md_present are instances of the 'model' class
    if ~isa(md_hist, 'model') || ~isa(md_present, 'model')
        error('Invalid model objects. Please provide instances of the ''model'' class.');
    end

    % Check if steps is a numeric array
    if ~isnumeric(steps)
        error('Invalid input type for steps. Please provide a numeric array.');
    end

    % Check if the specified time steps are available in md_hist
    tr_step = size(md_hist.results.TransientSolution, 2);
    if tr_step <= 0
        error('Invalid time step index. No available time steps in md_hist.');
    end
    if tr_step <= 16
        error('not wnugh timestep for 17 year gradient or wrong output frquency!');
    end

    org=organizer('repository',['./Models'],'prefix',['HIST1932_2023_'],'steps',steps, 'color', '34;47;2'); 
    tr_step = size(md_hist.results.TransientSolution, 2);
    last =tr_step-17;
    dhdt_smith = get_smith_from_md;

    if perform(org,'whole_AIS_only'),% {{{
        time =[];
        rmse_AIS=[];
        mask = md_present.mask.ice_levelset<0;
        for i =63:last
            t= md_hist.results.TransientSolution(i).time;
            dhdt_model =calc_thickness_change_17years(md_hist,i);
            diff = dhdt_smith-dhdt_model;
            rmse_i =calc_rmse_diff(md_present,diff,mask);
            time = [time t];
            rmse_AIS = [rmse_AIS rmse_i];
        end
        RMSEstruc.time =time;
        RMSEstruc.rmse_AIS =rmse_AIS;

    end% }}}

    if perform(org,'AIS_and_PIGTHW_basin_id')% {{{
        time =[];
        rmse_AIS=[];
        rmse_PIG=[];
        mask = md_present.mask.ice_levelset<0;
        mask_pig = mask_basin_id_ice(mask,md_hist,10); %10 is PIg and Thwaites
        for i =63:last
            t= md_hist.results.TransientSolution(i).time;
            dhdt_model =calc_thickness_change_17years(md_hist,i);
            diff = dhdt_smith-dhdt_model;
            rmse_i =calc_rmse_diff(md_present,diff,mask);
            rmse_ip =calc_rmse_diff(md_present,diff,mask_pig);
            time = [time t];
            rmse_AIS = [rmse_AIS rmse_i];
            rmse_PIG = [rmse_PIG rmse_ip];
        end
        RMSEstruc.time =time;
        RMSEstruc.rmse_AIS =rmse_AIS;
        RMSEstruc.rmse_PIG =rmse_PIG;


    end %}}}
    if perform(org,'AIS_and_PIGTHW_and_MscowTottwn_basin_id')% {{{
        time =[];
        rmse_AIS=[];
        rmse_PIG=[];
        rmse_TOTTEN=[];
        mask = md_present.mask.ice_levelset<0;
        mask_pig = mask_basin_id_ice(mask,md_hist,10); %10 is PIg and Thwaites
        mask_tot = mask_basin_id_ice(mask,md_hist,5); %5 it Totten and moscow university
        for i =63:last
            t= md_hist.results.TransientSolution(i).time;
            dhdt_model =calc_thickness_change_17years(md_hist,i);
            diff = dhdt_smith-dhdt_model;
            rmse_i =calc_rmse_diff(md_present,diff,mask);
            rmse_ip =calc_rmse_diff(md_present,diff,mask_pig);
            rmse_it =calc_rmse_diff(md_present,diff,mask_tot);
            time = [time t];
            rmse_AIS = [rmse_AIS rmse_i];
            rmse_PIG = [rmse_PIG rmse_ip];
            rmse_TOTTEN = [rmse_TOTTEN rmse_it];
        end
        RMSEstruc.time =time;
        RMSEstruc.rmse_AIS =rmse_AIS;
        RMSEstruc.rmse_PIG =rmse_PIG;
        RMSEstruc.rmse_TOTTEN =rmse_TOTTEN;


    end %}}}
