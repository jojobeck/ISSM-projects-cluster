function make_3_all_clim_plot(md_in,md_present,save_fig,varargin)
    if nargin < 4
        i_in = 1; % Default value for i_in
    else
        i_in = varargin{1};
    end
    md=md_in;
    sz = size(md.results.TransientSolution);
    % for i =1:1,
    for i =i_in:sz(2),
        name=['historic_clim_from_',num2str(i),'_',md_in.miscellaneous.name];
        model_pth = ['Models/' name];

        md_hist = loadmodel(model_pth);
        figname =[name ''];


        plot_4glaciers_clim(md_hist,md_present,figname,save_fig);
    end
