"""
    lin_sigma_v_ave(rho; cur_T_k=T_k)

Lorem ipsum dolor sit amet.
"""
function lin_sigma_v_ave(rho; cur_T_k=T_k)

  cur_k_array = sigma_v_k_array()

  cur_local_T = T_profile(rho, cur_T_k)

  cur_sigma_v_ave = 0.0

  for i in 0:length(cur_k_array)-1
    cur_term = cur_k_array[i+1]
    cur_term *= cur_local_T ^ i

    cur_sigma_v_ave += cur_term
  end

  cur_sigma_v_ave *= 1u"m^3/s"

  cur_sigma_v_ave

end
