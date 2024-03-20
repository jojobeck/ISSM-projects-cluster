function analyze_func(steps,numberofWorkers)
% numberOfWorkers =1;


    % loadonly = 1;
    addpath('./../scripts');



    org=organizer('repository',['./Models'],'prefix',['HIST1850_1930_'],'steps',steps, 'color', '34;47;2'); 
    % org=organizer('repository',['/Volumes/Crucial X8/SAEF/issm_project/AIS_1850/Models'],'prefix',['AIS1850_'],'steps',steps, 'color', '34;47;2'); 
    clear steps;
    % loadonly=1;
    % InterpFromMeshToMesh2d

    % clim runs 10-12c
    md_present = loadmodel('Models/AIS1850_CollapseSSA.mat');
    dist_gl_presentday = reinitializelevelset(md_present, md_present.mask.ocean_levelset);    

    if perform(org,'clim_from_2ka_PISMfriction_SMB4x'),% {{{

        md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x.mat');

        sz = size(md_in.results.TransientSolution);
        steps_all = [];
        dist_PIG_pd_all = [];
        dist_THW_pd_all = [];
        dist_Moscow_pd_all = [];
        dist_Totten_pd_all = [];
        dist_to_PIG1940_all = [];
        dist_to_THW1992_all = [];
        model_names = [];
        
        for i =1:20,
            disp(i);
            md.miscellaneous.name=['historic_clim_from_',num2str(i),'_',md_in.miscellaneous.name];
            pvel = './Models/';
            save_p= [pvel, name];
            md = loadmodel(save_p);
            szz = size(md.results.TransientSolution);
            steps=szz(2);

            dist_PIG_pd=calc_func_glchange_presentday(1,md,md_present,dist_gl_presentday);
            dist_THW_pd=calc_func_glchange_presentday(2,md,md_present,dist_gl_presentday);
            dist_Moscow_pd=calc_func_glchange_presentday(3,md,md_present,dist_gl_presentday);
            dist_Totten_pd=calc_func_glchange_presentday(4,md,md_present,dist_gl_presentday);
            dist_to_PIG1940=calc_func_glchange_PigTHWpast(1,md);
            dist_to_THW1992  =calc_func_glchange_PigTHWpast(2,md);
            disp(dist_to_THW1992);
            disp(dist_to_PIG1940);
            disp(name);
            disp(dist_THW_pd);
            disp(dist_PIG_pd);
            disp(dist_Totten_pd);
            disp(dist_Moscow_pd);
            
            steps_all = [steps_all ; steps];
            dist_PIG_pd_all = [dist_PIG_pd_all ; dist_PIG_pd];
            dist_THW_pd_all = [dist_THW_pd_all ; dist_THW_pd];
            dist_Moscow_pd_all = [dist_Moscow_pd_all ; dist_Moscow_pd];
            dist_Totten_pd_all = [dist_Totten_pd_all ; dist_Totten_pd];
            dist_to_PIG1940_all = [dist_to_PIG1940_all ; dist_to_PIG1940];
            dist_to_THW1992_all = [dist_to_THW1992_all ; dist_to_THW1992];
            model_names =[model_names ; i];
            disp(model_names);
        end
            T = table(model_names,steps_all,dist_PIG_pd_all,dist_THW_pd_all,dist_Moscow_pd_all,dist_Totten_pd_all,dist_to_PIG1940_all,dist_to_THW1992_all); 
            name_table = ['./Data/Tables/','historic_clim_from_1-2ka_PISMfriction_SMB4x.txt'];
            writetable(T, name_table) ;


    end% }}}
if perform(org,'clim_from_2ka_Cfriction_nn_SMB4x'),% {{{

    md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_nn_SMB4x.mat');

    sz = size(md_in.results.TransientSolution);
    % for i =1:sz(2),
    steps_all = [];
    dist_PIG_pd_all = [];
    dist_THW_pd_all = [];
    dist_Moscow_pd_all = [];
    dist_Totten_pd_all = [];
    dist_to_PIG1940_all = [];
    dist_to_THW1992_all = [];
    model_names = [];
    
    for i =1:20,
    % for i =10:10,
        disp(i);
        name=['historic_clim_from_',num2str(i),'_',md_in.miscellaneous.name];
        % gl_name=['historic_from_',num2str(i),'_-1930_from_1ka_2INVCfriction_mean_SMB4_gl_transientend.exp'];
        pvel = './Models/';
        save_p= [pvel, name];
        md = loadmodel(save_p);
        szz = size(md.results.TransientSolution);
        steps=szz(2);
        % h0=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','./Data/Tables/',gl_name);

        dist_PIG_pd=calc_func_glchange_presentday(1,md,md_present,dist_gl_presentday);
        dist_THW_pd=calc_func_glchange_presentday(2,md,md_present,dist_gl_presentday);
        dist_Moscow_pd=calc_func_glchange_presentday(3,md,md_present,dist_gl_presentday);
        dist_Totten_pd=calc_func_glchange_presentday(4,md,md_present,dist_gl_presentday);
        dist_to_PIG1940=calc_func_glchange_PigTHWpast(1,md);
        dist_to_THW1992  =calc_func_glchange_PigTHWpast(2,md);
        disp(dist_to_THW1992);
        disp(dist_to_PIG1940);
        disp(name);
        disp(dist_THW_pd);
        disp(dist_PIG_pd);
        disp(dist_Totten_pd);
        disp(dist_Moscow_pd);
        
        steps_all = [steps_all ; steps];
        dist_PIG_pd_all = [dist_PIG_pd_all ; dist_PIG_pd];
        dist_THW_pd_all = [dist_THW_pd_all ; dist_THW_pd];
        dist_Moscow_pd_all = [dist_Moscow_pd_all ; dist_Moscow_pd];
        dist_Totten_pd_all = [dist_Totten_pd_all ; dist_Totten_pd];
        dist_to_PIG1940_all = [dist_to_PIG1940_all ; dist_to_PIG1940];
        dist_to_THW1992_all = [dist_to_THW1992_all ; dist_to_THW1992];
        model_names =[model_names ; i];
        disp(model_names);
    end
        T = table(model_names,steps_all,dist_PIG_pd_all,dist_THW_pd_all,dist_Moscow_pd_all,dist_Totten_pd_all,dist_to_PIG1940_all,dist_to_THW1992_all); 
        name_table = ['./Data/Tables/','historic_clim_from_2ka_Cfriction_nn_SMB4_submit'];
        writetable(T, name_table) ;


end% }}}
if perform(org,'clim_from_2ka_Cfriction_mean_SMB4x'),% {{{

    md_in=loadmodel('./Models/AIS1850_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');

    sz = size(md_in.results.TransientSolution);
    % for i =1:sz(2),
    steps_all = [];
    dist_PIG_pd_all = [];
    dist_THW_pd_all = [];
    dist_Moscow_pd_all = [];
    dist_Totten_pd_all = [];
    dist_to_PIG1940_all = [];
    dist_to_THW1992_all = [];
    model_names = [];
    
    for i =1:20,
    % for i =10:10,
        disp(i);
        name=['historic_clim_from_',num2str(i),'_',md_in.miscellaneous.name];

        pvel = './Models/';
        save_p= [pvel, name];
        md = loadmodel(save_p);
        szz = size(md.results.TransientSolution);
        steps=szz(2);
        % h0=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','./Data/Tables/',gl_name);

        dist_PIG_pd=calc_func_glchange_presentday(1,md,md_present,dist_gl_presentday);
        dist_THW_pd=calc_func_glchange_presentday(2,md,md_present,dist_gl_presentday);
        dist_Moscow_pd=calc_func_glchange_presentday(3,md,md_present,dist_gl_presentday);
        dist_Totten_pd=calc_func_glchange_presentday(4,md,md_present,dist_gl_presentday);
        dist_to_PIG1940=calc_func_glchange_PigTHWpast(1,md);
        dist_to_THW1992  =calc_func_glchange_PigTHWpast(2,md);
        disp(dist_to_THW1992);
        disp(dist_to_PIG1940);
        disp(name);
        disp(dist_THW_pd);
        disp(dist_PIG_pd);
        disp(dist_Totten_pd);
        disp(dist_Moscow_pd);
        
        steps_all = [steps_all ; steps];
        dist_PIG_pd_all = [dist_PIG_pd_all ; dist_PIG_pd];
        dist_THW_pd_all = [dist_THW_pd_all ; dist_THW_pd];
        dist_Moscow_pd_all = [dist_Moscow_pd_all ; dist_Moscow_pd];
        dist_Totten_pd_all = [dist_Totten_pd_all ; dist_Totten_pd];
        dist_to_PIG1940_all = [dist_to_PIG1940_all ; dist_to_PIG1940];
        dist_to_THW1992_all = [dist_to_THW1992_all ; dist_to_THW1992];
        model_names =[model_names ; i];
        disp(model_names);
    end
        T = table(model_names,steps_all,dist_PIG_pd_all,dist_THW_pd_all,dist_Moscow_pd_all,dist_Totten_pd_all,dist_to_PIG1940_all,dist_to_THW1992_all); 
        name_table = ['./Data/Tables/','historic_clim_from_2ka_Cfriction_mean_SMB4_submit'];
        writetable(T, name_table) ;


end% }}}
    if perform(org,'clim_from_2ka_2INVCfriction_mean_SM4x'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');

        sz = size(md_in.results.TransientSolution);
        % for i =1:sz(2),
        steps_all = [];
        dist_PIG_pd_all = [];
        dist_THW_pd_all = [];
        dist_Moscow_pd_all = [];
        dist_Totten_pd_all = [];
        dist_to_PIG1940_all = [];
        dist_to_THW1992_all = [];
        model_names = [];
        
        for i =1:sz(2),
        % for i =10:10,
            disp(i);
            name=['historic_clim_from_',num2str(i),'_',md_in.miscellaneous.name];
            pvel = './Models/';
            save_p= [pvel, name];
            md = loadmodel(save_p);
            szz = size(md.results.TransientSolution);
            steps=szz(2);
            % h0=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','./Data/Tables/',gl_name);

            dist_PIG_pd=calc_func_glchange_presentday(1,md,md_present,dist_gl_presentday);
            dist_THW_pd=calc_func_glchange_presentday(2,md,md_present,dist_gl_presentday);
            dist_Moscow_pd=calc_func_glchange_presentday(3,md,md_present,dist_gl_presentday);
            dist_Totten_pd=calc_func_glchange_presentday(4,md,md_present,dist_gl_presentday);
            dist_to_PIG1940=calc_func_noglexeed_PigTHWpast_Cnn_Cmean(1,md);
            dist_to_THW1992  =calc_func_noglexeed_PigTHWpast_Cnn_Cmean(2,md);
            disp(dist_to_THW1992);
            disp(dist_to_PIG1940);
            disp(name);
            disp(dist_THW_pd);
            disp(dist_PIG_pd);
            disp(dist_Totten_pd);
            disp(dist_Moscow_pd);
            
            steps_all = [steps_all ; steps];
            dist_PIG_pd_all = [dist_PIG_pd_all ; dist_PIG_pd];
            dist_THW_pd_all = [dist_THW_pd_all ; dist_THW_pd];
            dist_Moscow_pd_all = [dist_Moscow_pd_all ; dist_Moscow_pd];
            dist_Totten_pd_all = [dist_Totten_pd_all ; dist_Totten_pd];
            dist_to_PIG1940_all = [dist_to_PIG1940_all ; dist_to_PIG1940];
            dist_to_THW1992_all = [dist_to_THW1992_all ; dist_to_THW1992];
            model_names =[model_names ; i];
            disp(model_names);
        end
            T = table(model_names,steps_all,dist_PIG_pd_all,dist_THW_pd_all,dist_Moscow_pd_all,dist_Totten_pd_all,dist_to_PIG1940_all,dist_to_THW1992_all); 
            name_table = ['./Data/Tables/','historic_clim_from_2ka_2INVCfriction_mean_SMB4_experiment.txt'];
            writetable(T, name_table) ;


    end% }}}
    % *oceanPIG95percentile
    if perform(org,'clim_from_2ka_2INVCfriction_mean_SM4x_oceanPIG95percentile'),% {{{

        md_in=loadmodel('./Models/AIS1850_RedoforTHW_nobasal_melt_nonlocal_1-2ka_Cfriction_mean_SMB4x.mat');

        sz = size(md_in.results.TransientSolution);
        % for i =1:sz(2),
        steps_all = [];
        dist_PIG_pd_all = [];
        dist_THW_pd_all = [];
        dist_Moscow_pd_all = [];
        dist_Totten_pd_all = [];
        dist_to_PIG1940_all = [];
        dist_to_THW1992_all = [];
        model_names = [];
        
        for i =1:sz(2),
        % for i =10:10,
            disp(i);
            name=['historic_clim_oceanPIG95percentile_from_',num2str(i),'_',md_in.miscellaneous.name];
            pvel = './Models/';
            save_p= [pvel, name];
            md = loadmodel(save_p);
            szz = size(md.results.TransientSolution);
            steps=szz(2);
            % h0=isoline(md,md.results.TransientSolution(end).MaskOceanLevelset,'value',0,'output','./Data/Tables/',gl_name);

            dist_PIG_pd=calc_func_glchange_presentday(1,md,md_present,dist_gl_presentday);
            dist_THW_pd=calc_func_glchange_presentday(2,md,md_present,dist_gl_presentday);
            dist_Moscow_pd=calc_func_glchange_presentday(3,md,md_present,dist_gl_presentday);
            dist_Totten_pd=calc_func_glchange_presentday(4,md,md_present,dist_gl_presentday);
            dist_to_PIG1940=calc_func_noglexeed_PigTHWpast_Cnn_Cmean(1,md);
            dist_to_THW1992  =calc_func_noglexeed_PigTHWpast_Cnn_Cmean(2,md);
            disp(dist_to_THW1992);
            disp(dist_to_PIG1940);
            disp(name);
            disp(dist_THW_pd);
            disp(dist_PIG_pd);
            disp(dist_Totten_pd);
            disp(dist_Moscow_pd);
            
            steps_all = [steps_all ; steps];
            dist_PIG_pd_all = [dist_PIG_pd_all ; dist_PIG_pd];
            dist_THW_pd_all = [dist_THW_pd_all ; dist_THW_pd];
            dist_Moscow_pd_all = [dist_Moscow_pd_all ; dist_Moscow_pd];
            dist_Totten_pd_all = [dist_Totten_pd_all ; dist_Totten_pd];
            dist_to_PIG1940_all = [dist_to_PIG1940_all ; dist_to_PIG1940];
            dist_to_THW1992_all = [dist_to_THW1992_all ; dist_to_THW1992];
            model_names =[model_names ; i];
            disp(model_names);
        end
            T = table(model_names,steps_all,dist_PIG_pd_all,dist_THW_pd_all,dist_Moscow_pd_all,dist_Totten_pd_all,dist_to_PIG1940_all,dist_to_THW1992_all); 
            name_table = ['./Data/Tables/','historic_clim_oceanPIG95percentile_from_2ka_2INVCfriction_mean_SMB4_experiment.txt'];
            writetable(T, name_table) ;


    end% }}}


