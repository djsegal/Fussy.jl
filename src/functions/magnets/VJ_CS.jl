@doc """
    VJ_CS(cur_solution=solve_magnet_equations())

Volume of HTS.
"""
@memoize function VJ_CS(cur_solution=solve_magnet_equations())

  a1, da = cur_solution

  cur_a2CS = a2CS(cur_solution)

  cur_hts_thickness = hts_thickness()

  cur_VJ_CS = 0.0

  cur_VJ_CS += ( ( cur_a2CS + a1 ) + cur_hts_thickness ) ^ 2 / 4

  cur_VJ_CS -= ( ( cur_a2CS + a1 ) - cur_hts_thickness ) ^ 2 / 4

  cur_VJ_CS *= solenoid_length()

  cur_VJ_CS *= pi

  cur_VJ_CS

end
