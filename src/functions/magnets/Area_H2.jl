"""
    Area_H2(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Determine Cooling Channel Dimensions.
"""
function Area_H2(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  tmp_area = Area_St(cur_R_0, cur_n_bar, cur_I_M)

  tmp_area += Area_Cu(cur_R_0, cur_n_bar, cur_I_M)

  # Integrated heat flux along one cable length [W/m^2]

  Q_int = 1 - exp( -0.029 * WP_d() )

  Q_int *= magnet_Q_max

  Q_int /= 0.029

  # Heat required to be removed from winding pack

  Q_H2 = Q_int * tmp_area

  # Required mass flow rate to remove winding pack heat load per coil

  Cable_mdot = Q_H2

  Cable_mdot /= magnet_Cp_H2

  Cable_mdot /= magnet_dT_H2

  # finds cooling diameter based on mdot and max pressure drop allowed

  Cable_Dh = magnet_friction_factor

  Cable_Dh *= Cable_L(cur_R_0, cur_n_bar, cur_I_M)

  Cable_Dh *= Cable_mdot ^ 2

  Cable_Dh *= 8

  Cable_Dh /= 69.7

  Cable_Dh /= pi ^ 2

  Cable_Dh /= magnet_dP_max

  Cable_Dh ^= 1 / 5

  # area of H2 cooling

  cur_Area_H2 = ( pi / 4 ) * Cable_Dh ^ 2

  cur_Area_H2

end
