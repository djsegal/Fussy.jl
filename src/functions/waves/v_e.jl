"""
    v_e(rho)

Lorem ipsum dolor sit amet.
"""
function v_e(rho)
  cur_v_e = T_profile(rho)

  mekev = 510.998 # kev/c^2

  cur_v_e /= mekev

  cur_v_e = sqrt(cur_v_e)

  cur_v_e *= ( Unitful.c0 / 1u"m/s" )

  cur_v_e
end
