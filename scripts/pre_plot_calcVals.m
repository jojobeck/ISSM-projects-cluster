function pre_plot_calcVals(md,steps)
    org=organizer('repository',['./Models'],'prefix',['ISMIP6Antarctica_'],'steps',steps, 'color', '34;47;2'); 
    save_fig =false;
    clear steps;
    addpath('../scripts/');


    if perform(org,'create_flowline_values'),% {{{
        res = 1000;
        exp_file = './../Exp/PIG_fl_drawn.exp';
        transient_flowline_extraction(md,exp_file,res)
        exp_file = './../Exp/THW_fl_drawn.exp';
        transient_flowline_extraction(md,exp_file,res)
    end %}}}
    if perform(org,'table_aggregated_values_basin'),% {{{
        num =10;
        save_table_basin(md, num)
    end %}}}
    if perform(org,'Table_aggregated_values_exp'),% {{{
        expfile = '../Exp/PigDomain_drwan.exp';
        save_table_exp(md,expfile);
        expfile = '../Exp/THWDomain_drwan.exp';
        save_table_exp(md,expfile);
    end %}}}
