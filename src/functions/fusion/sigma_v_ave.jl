"""
    sigma_v_ave(rho)

Lorem ipsum dolor sit amet.
"""
function sigma_v_ave(rho)

  l_fit = [
    +8.47607337488889,
    -15.0271611662417,
    +3.54811022268999,
    -0.113845397989482,
    +1.42248439810972e-3,
    -6.27906321523389e-6
  ]

  l_fit *= 1e-24

  cur_param = 1
  cur_param -= rho ^ 2
  cur_param ^= nu_T

  cur_param *= ( T_k / 1u"keV" )
  cur_param *= 1 + nu_T

  cur_sigma_v_ave = l_fit[1]

  for i in 1:5
    cur_term = l_fit[i+1]
    cur_term *= cur_param ^ i

    cur_sigma_v_ave += cur_term
  end

  cur_sigma_v_ave = max(0, cur_sigma_v_ave)

  cur_sigma_v_ave *= 1u"m^3/s"

  cur_sigma_v_ave

end
