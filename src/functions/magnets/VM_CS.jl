"""
    VM_CS(cur_solution=solve_magnet_equations())

Volume of Structure.
"""
function VM_CS(cur_solution=solve_magnet_equations())

  a1, da = cur_solution

  cur_VM_CS = a2CS(cur_solution) ^ 2 - a1 ^ 2

  cur_VM_CS -= ( ( a2CS(cur_solution) + a1 ) + hts_thickness() ) ^ 2 / 4

  cur_VM_CS += ( ( a2CS(cur_solution) + a1 ) - hts_thickness() ) ^ 2 / 4

  cur_VM_CS *= Tokamak.solenoid_length()

  cur_VM_CS *= pi

  cur_VM_CS

end
