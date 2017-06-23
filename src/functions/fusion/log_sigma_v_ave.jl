"""
    log_sigma_v_ave(rho)

Lorem ipsum dolor sit amet.
"""
function log_sigma_v_ave(rho)

  l_fit = [
    -60.4593,
    +6.1371,
    -0.8609,
    +0.0356,
    -0.0045
  ]

  cur_param = 1.0
  cur_param -= rho ^ 2
  cur_param ^= nu_T

  cur_param *= ( T_k / 1u"keV" )
  cur_param *= 1 + nu_T

  cur_param = log( cur_param )

  cur_sigma_v_ave = 0.0

  for i in 0:4
    cur_term = l_fit[i+1]
    cur_term *= cur_param ^ i

    cur_sigma_v_ave += cur_term
  end

  cur_sigma_v_ave = exp( cur_sigma_v_ave )

  cur_sigma_v_ave *= 1u"m^3/s"

  cur_sigma_v_ave

end
