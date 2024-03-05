function d = get_d_for_colormax(diff_sim)
    d1=min(diff_sim);        
    d2=max(diff_sim);        
    d = max(abs(d1),abs(d2));  
