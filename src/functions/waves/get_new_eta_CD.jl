"""
    get_new_eta_CD(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD; verbose=false)

Lorem ipsum dolor sit amet.
"""
function get_new_eta_CD(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD; verbose=false)

  cur_solved_n_bar = subs(
    calc_possible_values(
      ( solved_steady_density() / 1u"n20" ),
      cur_T_k = ( cur_solved_T_k * 1u"keV" ),
      cur_eta_CD = prev_eta_CD
    ),
    symbol_dict["R_0"] => cur_solved_R_0
  )

  cur_solved_n_bar = SymPy.N(cur_solved_n_bar)

  cur_rho = solve_wave_equations(
    cur_solved_R_0, cur_solved_B_0, cur_solved_T_k,
    cur_solved_n_bar, verbose=verbose
  )

  if isnan(cur_rho)
    return [ NaN , NaN ]
  end

  cur_wave_chi = subs(
    wave_chi(cur_rho),
    symbol_dict["n_bar"] => cur_solved_n_bar,
    symbol_dict["R_0"] => cur_solved_R_0,
    symbol_dict["B_0"] => cur_solved_B_0,
    symbol_dict["T_k"] => cur_solved_T_k
  )

  cur_wave_chi = SymPy.N(cur_wave_chi)

  cur_omega_hat_2 = wave_omega_hat_2(
    cur_rho,
    cur_wave_chi = cur_wave_chi
  )

  cur_omega_hat_2 = SymPy.N(cur_omega_hat_2)

  cur_n_para_2 = wave_n_para_2(
    cur_rho,
    cur_wave_chi = cur_wave_chi,
    cur_omega_hat_2 = cur_omega_hat_2
  )

  new_n_para = sqrt(cur_n_para_2) + delta_n_para

  new_rho_j = wave_rho_j(cur_rho, new_n_para)

  cur_eta_tilde = wave_eta_tilde(
    new_rho_j,
    new_n_para,
    cur_solved_T_k
  )

  cur_eta_tilde = SymPy.N(cur_eta_tilde)

  if enable_log_lambda_calc
    log_lambda = subs(
      log( Plasmas.plasma_parameter() ),
      Plasmas.symbol_dict["T_e"] => cur_solved_T_k,
      Plasmas.symbol_dict["n_e"] => cur_solved_n_bar
    )
  else
    log_lambda = 19.0
  end

  cur_eta_CD = 0.06108

  cur_eta_CD *= eta_LH

  cur_eta_CD /= log_lambda

  cur_eta_CD *= T_profile(new_rho_j, cur_solved_T_k * 1u"keV")

  cur_eta_CD *= cur_eta_tilde

  cur_eta_CD = SymPy.N(cur_eta_CD)

  [ cur_eta_CD, cur_rho ]

end
