
function m_new =lin_func_till(x1,x2,m1,m2,x_new)
    slope =(m2-m1)/(x2-x1);
    m_new = slope*(x_new-x1)+m1;
