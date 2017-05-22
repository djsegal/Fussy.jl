"""
    VJ_CS(cur_solution=solve_magnet_equations())

Volume of HTS.
"""
function VJ_CS(cur_solution=solve_magnet_equations())

  a1, da = cur_solution

  cur_VJ_CS = 0.0

  cur_VJ_CS += ( ( a2CS(cur_solution) + a1 ) + hts_thickness() ) ^ 2 / 4

  cur_VJ_CS -= ( ( a2CS(cur_solution) + a1 ) - hts_thickness() ) ^ 2 / 4

  cur_VJ_CS *= Tokamak.solenoid_length()

  cur_VJ_CS *= pi

  cur_VJ_CS

end
