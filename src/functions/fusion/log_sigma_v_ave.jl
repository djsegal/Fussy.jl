"""
    log_sigma_v_ave(rho; cur_T_k=T_k)

Lorem ipsum dolor sit amet.
"""
function log_sigma_v_ave(rho; cur_T_k=T_k)

  cur_l_array = sigma_v_l_array()

  cur_local_T = log( local_T_k(rho, cur_T_k) )

  cur_sigma_v_ave = 0.0

  for i in 0:length(cur_l_array)-1
    cur_term = cur_l_array[i+1]
    cur_term *= cur_local_T ^ i

    cur_sigma_v_ave += cur_term
  end

  cur_sigma_v_ave = exp( cur_sigma_v_ave )

  cur_sigma_v_ave *= 1u"m^3/s"

  cur_sigma_v_ave

end
