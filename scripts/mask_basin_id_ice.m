function mask = mask_basin_id_ice(ice_mask,md_hist,num)
    %return where ice is on basin id , here want present day only
    m_basin =mask_basin_id(md_hist,num);
    mask = ice_mask & m_basin;
