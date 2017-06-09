"""
    solve_magnet_equations(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; verbose=false)

Define Inner Radius and Total Thickness.
"""
function solve_magnet_equations(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; verbose=false)

  # find roots of system of Flux & Stress Equations

  cur_initial_values = [ 0.4 , 0.2 ]

  cur_solution = nlsolve(
    @generate_magnet_equation_set(cur_R_0, cur_n_bar, cur_I_M),
    cur_initial_values, xtol = 1e-8, show_trace = verbose
  ).zero

  a1, da = cur_solution

  return a1, da

end
