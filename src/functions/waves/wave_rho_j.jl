"""
    wave_rho_j(cur_rho, new_n_para)

Lorem ipsum dolor sit amet.
"""
function wave_rho_j(cur_rho, new_n_para)

  cur_left_part = 1.0

  cur_left_part -= cur_rho ^ 2

  cur_right_part = delta_n_para

  cur_right_part /= new_n_para

  cur_right_part *= -1.0

  cur_right_part += 1.0

  cur_right_part ^= ( 2 / nu_T )

  cur_rho = 1.0 - cur_left_part * cur_right_part

  cur_rho ^= ( 1 / 2 )

  cur_rho = SymPy.N(cur_rho)

  cur_rho

end
