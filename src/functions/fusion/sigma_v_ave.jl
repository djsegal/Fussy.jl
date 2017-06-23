"""
    sigma_v_ave(rho)

Lorem ipsum dolor sit amet.
"""
function sigma_v_ave(rho)

  if use_lin_sigma_v_funcs
    cur_sigma_v_ave = lin_sigma_v_ave(rho)
  else
    cur_sigma_v_ave = log_sigma_v_ave(rho)
  end

  cur_sigma_v_ave

end
