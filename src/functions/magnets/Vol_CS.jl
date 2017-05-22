"""
    Vol_CS(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Vol_CS(cur_solution=solve_magnet_equations())

  cur_Vol_CS = VJ_CS(cur_solution)

  cur_Vol_CS += VM_CS(cur_solution)

  cur_Vol_CS

end
