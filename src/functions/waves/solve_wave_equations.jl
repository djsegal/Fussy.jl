"""
    solve_wave_equations(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD; verbose=false)

Function to solve for n_para, rho_J, omega.
"""
function solve_wave_equations(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD; verbose=false)
  rho_J = nothing

  for cur_attempt in 1:7
    did_work = true

    try
      rho_J = mcpsolve(
        @generate_wave_equation_set(cur_solved_R_0, cur_solved_B_0, cur_solved_T_k, prev_eta_CD),
        [-1.0], [1.0], [rand(linspace(0.1, 0.9))],
        ftol = 1e-6, xtol = 1e-4, iterations=50,
        show_trace = false,
      ).zero[1]

      rho_J = abs(rho_J)

      if isapprox(0, rho_J, atol=1e-8)
        did_work = false
      end
    catch DomainError
      did_work = false
    end

    if verbose ; print( did_work ? "+" : "*" ) ; end

    if did_work ; break ; end
  end

  if rho_J == nothing
    if verbose ; print("o") ; end
    return [ NaN , NaN , NaN ]
  end

  cur_n_bar = subs(
    calc_possible_values(
      ( solved_steady_density() / 1u"n20" ),
      cur_T_k = ( cur_solved_T_k * 1u"keV" ),
      cur_eta_CD = prev_eta_CD
    ),
    symbol_dict["R_0"] => cur_solved_R_0
  )

  cur_omega_nor2 = subs(
    omega_nor2(rho_J),
    symbol_dict["B_0"] => cur_solved_B_0,
    symbol_dict["n_bar"] => cur_n_bar
  )

  omega = subs(
    sqrt(
      cur_omega_nor2 *
      omega_ce(rho_J) *
      omega_ci(rho_J)
    ),
    symbol_dict["B_0"] => cur_solved_B_0
  )

  cur_n_para = subs(
    n_para(
      rho_J, cur_omega_nor2=cur_omega_nor2
    ),
    symbol_dict["B_0"] => cur_solved_B_0,
    symbol_dict["n_bar"] => cur_n_bar
  )

  output = [
    SymPy.N(cur_n_para),
    rho_J,
    SymPy.N(omega)
  ]

  return output
end
