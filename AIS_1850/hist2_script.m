
steps =1;
loadonly=0;
numberOfWorkers = 48;
org=organizer('repository',['./Models'],'prefix',['HIST1931_2030_'],'steps',steps, 'color', '34;47;2'); 

addpath('./../scripts');
p_table = 'Data/Tables/';
if perform(org,'-1930_from_2ka_nobasal_melt_nonlocal_1-2ka_PISMfriction_SMB4x_gl_to_presentday'),% {{{

    name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';

    namenew = [p_table 'cond_hist1_' name];
    T = readtable(namenew, 'Delimiter' , ',');
    for i =1:1
        md_in_path = ['Models/' T.model_names{i}];
        disp(md_in_path);
        md = model_continue_hist2(md_in_path);
        md=solve(md,'tr','runtimename',false,'loadonly',loadonly);
    end
end% }}}
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{
    name='historic_until_1930_from_2ka_Cfriction_mean_SMB4_submit.txt';

    md_end='_-1930_from_2ka_Cfriction_mean_SMB4_submit.mat';

    cond =condition_hist1(p_table,name);
    namenew = [p_table 'cond_hist1_' name];
    model_names = strings(size(cond));
    for i =1:size(cond),
        namem=['historic_from_',num2str(cond(i)),md_end];
        model_names(i)=namem;
     end
     T= table(model_names);
     writetable(T,namenew);


end% }}}`
if perform(org,'-1930_nobasal_melt_nonlocal_2ka_Cfriction_nn_SMB4x'),% {{{

name = 'historic_until_1930_from_2ka_Cfriction_nn_SMB4_submit.txt';
md_end ='_-1930_from_2ka_Cfriction_nn_SMB4_submit.mat';
cond =condition_hist1(p_table,name);
namenew = [p_table 'cond_hist1_' name];
model_names = strings(size(cond));
for i =1:size(cond),
    namem=['historic_from_',num2str(cond(i)),md_end];
    model_names(i)=namem;
 end
 T= table(model_names);
 writetable(T,namenew);


end% }}}
if perform(org,'-1930_from_2ka_RedoforTHW_nobasal_melt_nonlocal_2ka_Cfriction_mean_SMB4x'),% {{{
    name = 'historic_until_1930_from_2ka_2INVCfriction_mean_SMB4_experiment.txt';

    md_end = '_-1930_from_2ka_2INVCfriction_mean_SMB4_submit.mat';

    cond =condition_hist1(p_table,name);
    namenew = [p_table 'cond_hist1_' name];
    model_names = strings(size(cond));
    for i =1:size(cond),
        namem=['historic_from_',num2str(cond(i)),md_end];
        model_names(i)=namem;
     end
     T= table(model_names);
     writetable(T,namenew);


end% }}}
