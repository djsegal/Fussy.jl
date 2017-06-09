"""
    magnet_Q_total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

Total cooling equivalent at 4.5 K to use in Green formula [kW].
"""
function magnet_Q_total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

  # equivalent cooling powers at 4.5K [kW]

  Q_eq1 = magnet_Q_15(cur_R_0, cur_n_bar, cur_I_M, cur_solution=cur_solution)
  Q_eq1 /= 3.47

  Q_eq2 = magnet_Q_80()
  Q_eq2 /= 24

  Q_total = Q_eq1 + Q_eq2

end
