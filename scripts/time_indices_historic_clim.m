function inds = time_indices_historic_clim(time_start,time_end,dt)
if time_start ==1.
    i0=1;
else
    i0 =floor(time_start/10) +1;
end
ie = floor(time_end/10) +1;
inds = i0:dt:ie;
