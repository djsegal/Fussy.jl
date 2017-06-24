"""
    get_new_eta_CD(cur_solved_R_0, cur_solved_T_k; verbose=false)

Lorem ipsum dolor sit amet.
"""
function get_new_eta_CD(cur_solved_R_0, cur_solved_T_k; verbose=false)
  cur_solution = solve_wave_equations(cur_solved_R_0, cur_solved_T_k, verbose=verbose)

  n_para = cur_solution[1]
  rho_J = cur_solution[2]
  omega = cur_solution[3]

  delta_n_para = 0.2
  n_para_m = n_para+delta_n_para
  rho_J_m = sqrt( 1-(1-rho_J^2)*(1-delta_n_para/n_para_m )^(2.0/nu_T) )

  cur_eta_CD = calc_cur_eta_cd(n_para_m, rho_J_m, omega)

  cur_eta_CD = subs(
    cur_eta_CD, Tokamak.symbol_dict["T_k"], cur_solved_T_k
  )

  cur_eta_CD
end
