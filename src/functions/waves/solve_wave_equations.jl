"""
    solve_wave_equations(cur_solved_R_0, cur_solved_B_0)

Function to solve for n_para, rho_J, omega_nor2.
"""
function solve_wave_equations(cur_solved_R_0, cur_solved_B_0; verbose=false)
  cur_solution = nothing

  for cur_attempt in 1:20
    did_work = true

    try
      cur_initial_values = [
        rand(linspace(1.0, 3.0)),
        rand(linspace(0.0, 1.0)),
        rand(linspace(0.5, 3.0))
      ]

      cur_solution = mcpsolve(
        @generate_wave_equation_set(cur_solved_R_0, cur_solved_B_0),
        [0.0, 0.0, 0.0], [20.0, 1.0, 15.0], cur_initial_values, factor=5.0,
        show_trace = false, xtol = 1e-6, ftol = 5e-4, iterations=40
      ).zero

    catch
      did_work = false
    end

    if !did_work ; continue ; end

    if verbose ; print("✓") ; end
    break
  end

  if cur_solution == nothing
    if verbose ; print("x") ; end
    cur_solution = [ 0 , 0 , 0 ]
  end

  n_para = cur_solution[1]
  rho_J = cur_solution[2]
  omega_nor2 = cur_solution[3]

  omega = sqrt(omega_nor2.*omega_ce(rho_J).*omega_ci(rho_J))   #(eqn15)

  omega = subs(omega, symbol_dict["B_0"], cur_solved_B_0)

  output = Array(Any, 3)

  output[1] = n_para
  output[2] = rho_J
  output[3] = omega

  return output
end
