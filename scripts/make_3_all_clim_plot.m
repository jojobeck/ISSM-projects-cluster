function make_3_all_clim_plot(md_in,md_present,save_fig)
    md=md_in;
    sz = size(md.results.TransientSolution);
    % for i =1:1,
    for i =1:sz(2),
        namo=['historic_clim_from_',num2str(i),'_',md_in.miscellaneous.name];
        name=[namo '.mat'];
        model_pth = ['Models/' name];

        md_hist = loadmodel(model_pth);
        figname =[namo ''];


        plot_4glaciers_clim(md_hist,md_present,figname,save_fig);
    end
