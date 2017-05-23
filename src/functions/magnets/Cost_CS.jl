"""
    Cost_CS(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Cost_CS(cur_solution=solve_magnet_equations())

  cur_VJ_CS = VJ_CS(cur_solution)

  cur_left_term = 1 - magnet_hts_fraction

  cur_left_term *= cur_VJ_CS

  cur_left_term += VM_CS(cur_solution)

  cur_left_term *= St_Rho

  cur_left_term *= Price_St

  cur_right_term = magnet_hts_fraction

  cur_right_term *= cur_VJ_CS

  cur_right_term *= Price_HTS

  cur_right_term /= Area_Tape()

  cur_Cost_CS = cur_left_term + cur_right_term

  cur_Cost_CS

end
