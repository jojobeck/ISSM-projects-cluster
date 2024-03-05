function msk = mask_as_icelevelset(m_in)
    m1 = m_in ==1;
    msk = m_in;
    msk(m1)=-1;
    msk(~m1)=1;
