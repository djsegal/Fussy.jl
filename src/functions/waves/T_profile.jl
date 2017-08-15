"""
    T_profile(rho, ave_T_k=T_k)

Lorem ipsum dolor sit amet.
"""
function T_profile(rho, ave_T_k=T_k)

  cur_T_profile = ( 1 - rho ^ 2 ) ^ nu_T

  cur_T_profile *= ( 1 + nu_T )

  cur_T_profile *= ( ave_T_k / 1u"keV" )

  cur_T_profile

end
