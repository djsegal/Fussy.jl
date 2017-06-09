"""
    Area_Cu(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Determine Copper Stablizer Dimensions.
"""
function Area_Cu(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_Area_Cu = Coil_Energy(cur_R_0, cur_n_bar, cur_I_M)

  cur_Area_Cu /= Cu_Cp(magnet_Tcs)

  cur_Area_Cu /= Cu_Rho

  cur_Area_Cu /= ( 150 - magnet_Tcs )

  cur_Area_Cu /= Coil_P(cur_R_0, cur_n_bar, cur_I_M)

  cur_Area_Cu /= magnet_turns()

  cur_Area_Cu -= ( 0.94 * Area_HTS() )

  cur_Area_Cu

end
