"""
    VM_CS()

Lorem ipsum dolor sit amet.
"""
function VM_CS()
  a1, da = solve_magnet_equations()
  cur_VM_CS = pi*( (a2CS())^2 - ((a2CS()+a1)/2 + hts_thickness()/2)^2 + ((a2CS()+a1)/2 - hts_thickness()/2)^2 - a1^2)*Tokamak.solenoid_length() # Volume of Structure
  cur_VM_CS
end
