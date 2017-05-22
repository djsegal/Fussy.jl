"""
    VM_CS(cur_solution=solve_magnet_equations())

Volume of Structure.
"""
function VM_CS(cur_solution=solve_magnet_equations())

  a1, da = cur_solution

  cur_a2CS = a2CS(cur_solution)

  cur_hts_thickness = hts_thickness()

  cur_VM_CS = cur_a2CS ^ 2 - a1 ^ 2

  cur_VM_CS -= ( ( cur_a2CS + a1 ) + cur_hts_thickness ) ^ 2 / 4

  cur_VM_CS += ( ( cur_a2CS + a1 ) - cur_hts_thickness ) ^ 2 / 4

  cur_VM_CS *= solenoid_length()

  cur_VM_CS *= pi

  cur_VM_CS

end
