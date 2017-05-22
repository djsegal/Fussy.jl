"""
    solve_magnet_equations()

Lorem ipsum dolor sit amet.
"""
function solve_magnet_equations()

  ## Call fsolve to find roots of system of Flux & Stress Equations
  x0 = [0.4,0.2]
  x = nlsolve(magnet_equation_set!,x0).zero

  ## Define Inner Radius and Total Thickness
  a1, da = x

  return a1, da

end
