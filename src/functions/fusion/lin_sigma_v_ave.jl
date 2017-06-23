"""
    lin_sigma_v_ave(rho)

Lorem ipsum dolor sit amet.
"""
function lin_sigma_v_ave(rho)

  cur_k_array = sigma_v_k_array()

  cur_param = 1.0
  cur_param -= rho ^ 2
  cur_param ^= nu_T

  cur_param *= ( T_k / 1u"keV" )
  cur_param *= 1 + nu_T

  cur_sigma_v_ave = 0.0

  for i in 0:length(cur_k_array)-1
    cur_term = cur_k_array[i+1]
    cur_term *= cur_param ^ i

    cur_sigma_v_ave += cur_term
  end

  cur_sigma_v_ave *= 1u"m^3/s"

  cur_sigma_v_ave

end
