"""
    solve_wave_equations(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD; verbose=false)

Function to solve for n_para, rho_J, omega.
"""
function solve_wave_equations(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD; verbose=false)
  rho_J = nothing

  for cur_attempt in 1:10
    did_work = true

    try
      rho_J = nlsolve(
        @generate_wave_equation_set(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD),
        [rand(linspace(0.1, 0.9))],
        show_trace = false, xtol = 1e-2, ftol = 1e-5, iterations=40
      ).zero[1]
    catch DomainError
      did_work = false
    end

    if !did_work ; continue ; end

    if verbose ; print("✓") ; end
    break
  end

  if rho_J == nothing
    if verbose ; print("x") ; end
    return [ NaN , NaN , NaN ]
  end

  cur_n_para = n_para(rho_J)

  cur_omega_nor2 = omega_nor2(rho_J)

  omega = sqrt(cur_omega_nor2.*omega_ce(rho_J).*omega_ci(rho_J))   #(eqn15)

  output = Array{Any}(3)

  output[1] = cur_n_para
  output[2] = rho_J
  output[3] = omega

  cur_n_bar = subs(
    calc_possible_values(
      ( solved_steady_density() / 1u"n20" ),
      cur_T_k = ( cur_solved_T_k * 1u"keV" ),
      cur_eta_CD = prev_eta_CD
    ),
    symbol_dict["R_0"] => cur_solved_R_0
  )

  output = map(
    x -> subs(x,
      symbol_dict["B_0"] => cur_solved_B_0,
      symbol_dict["n_bar"] => cur_n_bar
    ),
    output
  )

  return output
end
