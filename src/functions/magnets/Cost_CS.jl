"""
    Cost_CS(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Cost_CS(cur_solution=solve_magnet_equations())

  cur_left_term = 1 - Tokamak.magnet_hts_fraction

  cur_left_term *= VJ_CS(cur_solution)

  cur_left_term += VM_CS(cur_solution)

  cur_left_term *= 8000

  cur_left_term *= Tokamak.Price_St

  cur_right_term = Tokamak.magnet_hts_fraction

  cur_right_term *= VJ_CS(cur_solution)

  cur_right_term *= Tokamak.Price_HTS

  cur_right_term /= Tokamak.Area_Tape()

  cur_Cost_CS = cur_left_term + cur_right_term

  cur_Cost_CS

end
