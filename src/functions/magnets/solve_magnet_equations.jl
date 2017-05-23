"""
    solve_magnet_equations()

Define Inner Radius and Total Thickness.
"""
function solve_magnet_equations(verbose=false)

  # find roots of system of Flux & Stress Equations

  cur_initial_values = [ 0.4 , 0.2 ]

  cur_solution = nlsolve(
    magnet_equation_set!,
    cur_initial_values, xtol = 1e-8, show_trace = verbose
  ).zero

  a1, da = cur_solution

  return a1, da

end
