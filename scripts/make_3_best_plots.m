function make_3_best_plots(name,figname_in,save_fig)
        parts = strsplit(name, 'from_');
        parts2 =strsplit(parts{2},'_SMB4x.txt');
        namo = parts2{1};


        name_table = ['./Data/Tables/','orderd_experiments_weighted_within_exptype_' namo '.txt'];
        T_order = readtable(name_table, 'Delimiter' , ',');
        name_table = ['./Data/Tables/','time_min_distance_hist2_runs' namo '.txt'];
        T_i = readtable(name_table, 'Delimiter' , ',');
        i_end=size(T_order,1);
% for i=1:3
        for i=1:1
            runName=['hist2_' T_order.model_names{i}];
            model_pth = ['Models/' runName];

            md_hist = loadmodel(model_pth);
            figname =[figname_in '_' num2str(i)];


            %TODO add figname change

            j=T_order.indices(i);
            ii = find(T_i.model_names==j);
            %get the best inidces for hist and p.d. gl.
            times_irun=zeros(1,6);
            
            %gl. to pig1940
            times_irun(1)=T_i(ii,2).Variables;
            %gl. to THW 1992
            times_irun(2)=T_i(ii,3).Variables+59;
            %gl to present pig,thw,moscow totten

            times_irun(3)=T_i(ii,4).Variables+79;
            times_irun(4)=T_i(ii,5).Variables+79;
            times_irun(5)=T_i(ii,6).Variables+79;
            times_irun(6)=T_i(ii,7).Variables+79;

            %TODO: adhjust plooting MAKE fucntion above
            plot_4glaciers_hist2eval(md_hist,times_irun,figname,save_fig);
       end
