"""
    T_profile(rho)

Lorem ipsum dolor sit amet.
"""
function T_profile(rho)
  cur_T_profile = ( 1 - rho ^ 2 ) ^ nu_T

  cur_T_profile *= ( T_k / 1u"keV" )

  cur_T_profile *= ( 1 + nu_T )

  cur_T_profile
end
