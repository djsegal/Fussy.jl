"""
    sigma_v()

Lorem ipsum dolor sit amet.
"""
function sigma_v()

  if use_lin_sigma_v_funcs
    cur_sigma_v = lin_sigma_v()
  else
    cur_sigma_v = log_sigma_v()
  end

  cur_sigma_v

end
