"""
    power_balance_r_exp()

Lorem ipsum dolor sit amet.
"""
function power_balance_r_exp()
  cur_eq_exp = 1 + alphas["n_bar"]

  cur_eq_exp *= 2

  cur_eq_exp -= alphas["P"]

  cur_eq_exp -= alphas["R_0"]

  cur_eq_exp -= alphas["a"]

  cur_eq_exp
end
