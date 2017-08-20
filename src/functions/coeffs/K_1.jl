"""
    K_1()

Lorem ipsum dolor sit amet.
"""
function K_1()
  cur_K_1 = K_tau()

  cur_K_1 *= K_I() ^ alphas["I_M"]

  n_exp = alphas["n_bar"] + 1
  n_exp -= 2 * alphas["P"]

  cur_K_1 *= K_n() ^ n_exp

  cur_K_1 /= K_F() ^ alphas["P"]

  cur_K_1 /= K_law()

  cur_K_1 /= Q_kernel() ^ alphas["P"]

  cur_K_1 *= epsilon ^ alphas["a"]

  cur_K_1 *= A ^ alphas["A"]

  cur_K_1 *= kappa ^ alphas["kappa"]

  cur_K_1
end
