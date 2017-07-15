"""
    sigma_v_ave(rho; cur_T_k=T_k)

Lorem ipsum dolor sit amet.
"""
function sigma_v_ave(rho; cur_T_k=T_k)

  if !use_slow_sigma_v_funcs
    return lin_sigma_v_ave(rho, cur_T_k=cur_T_k)
  end

  if !use_bosch_hale_sigma_v
    return log_sigma_v_ave(rho, cur_T_k=cur_T_k)
  end

  bosch_hale_sigma_v_ave(rho, cur_T_k=cur_T_k)

end
