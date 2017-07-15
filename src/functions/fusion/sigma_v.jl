"""
    sigma_v(cur_T_k=T_k)

Lorem ipsum dolor sit amet.
"""
function sigma_v(cur_T_k=T_k)

  if use_slow_sigma_v_funcs
    cur_sigma_v = slow_sigma_v(cur_T_k)
  else
    cur_sigma_v = lin_sigma_v(cur_T_k)
  end

  cur_sigma_v

end
