"""
    a2CS(cur_solution=solve_magnet_equations())

Outer Radius.
"""
function a2CS(cur_solution=solve_magnet_equations())

  a1, da = cur_solution

  cur_a2CS = a1 + da

  cur_a2CS

end
