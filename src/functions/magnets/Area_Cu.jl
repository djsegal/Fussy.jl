"""
    Area_Cu()

Determine Copper Stablizer Dimensions.
"""
function Area_Cu()

  cur_Area_Cu = Coil_Energy()

  cur_Area_Cu /= Cu_Cp(magnet_Tcs)

  cur_Area_Cu /= Cu_Rho

  cur_Area_Cu /= ( 150 - magnet_Tcs )

  cur_Area_Cu /= Coil_P()

  cur_Area_Cu /= magnet_turns()

  cur_Area_Cu -= ( 0.94 * Area_HTS() )

  cur_Area_Cu

end
