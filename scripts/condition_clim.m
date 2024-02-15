function numbers_cond =condition_clim(p_table,name)                                                                                                                                                                
% name ='historic_until_1930_from_1-2ka_PISMfriction_SMB4x.txt';
tabnam = [p_table name];                       
T = readtable(tabnam);                         
T_log =T;                                      
T_log.dist_to_THW1992_all =  T.dist_to_THW1992_all >0;
T_log.dist_to_PIG1940_all = T.dist_to_PIG1940_all >0;
T_log.dist_PIG_pd_all = T.dist_PIG_pd_all <0;  
T_log.dist_THW_pd_all = T.dist_THW_pd_all <0;  
T_log.dist_Moscow_pd_all = T.dist_Moscow_pd_all <0;
T_log.dist_Totten_pd_all  = T.dist_Totten_pd_all  <0;
T_log.steps_all = T.steps_all ==101;             
sz = size(T_log);                              
mean_cond =[];                                 
for i=1:sz(1),                                 
    mean_cond = [mean_cond mean( T_log(i,2:end).Variables )];
end                                            
 all_true = mean_cond ==1;                     
 numbers_cond = T.model_names(all_true);
