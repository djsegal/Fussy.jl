"""
    VJ_CS()

Lorem ipsum dolor sit amet.
"""
function VJ_CS()
  a1, da = solve_magnet_equations()
  cur_VJ_CS = pi*( ((a2CS()+a1)/2 + hts_thickness()/2)^2 - ((a2CS()+a1)/2 - hts_thickness()/2)^2)*Tokamak.solenoid_length() # Volume of HTS
  cur_VJ_CS
end
