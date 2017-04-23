"""
    heat_load_limit()

Lorem ipsum dolor sit amet.
"""
function heat_load_limit()
  cur_head_load = P_kappa()

  cur_head_load += power_balance()

  cur_head_load *= B_0

  cur_head_load /= R_0

  cur_head_load -= h_parallel

  cur_head_load
end
