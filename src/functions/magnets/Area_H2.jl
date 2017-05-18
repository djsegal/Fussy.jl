"""
    Area_H2()

Determine Cooling Channel Dimensions.
"""
function Area_H2()
  A = (Area_St()+Area_Cu())
  Cp_H2 = 10000 # Average specific heat of supercritical hydrogen @ 30bar from 20-55K
  dT_H2 = 10 # Allowable temperature rise in the fluid
  Q_int = (magnet_Q_max/0.029)*(1-exp(-.029*(WP_d()))) # Integrated heat flux along one cable length [W/m^2]
  Q_H2 = Q_int*(A) # Heat required to be removed from winding pack
  Cable_mdot = Q_H2/Cp_H2/dT_H2 # Required mass flow rate to remove winding pack heat load per coil
  friction_factor=0.015 # Cooling channel friction factor
  dP_max = 0.01e6 # Allowable pressure drop in the cable
  Cable_Dh = (friction_factor*Cable_L()*(Cable_mdot)^2*8/(69.7*pi^2*(dP_max)))^(1/5) # finds cooling diameter based on mdot and max pressure drop allowed
  cur_Area_H2 = (pi/4)*Cable_Dh^2 # area of H2 cooling

  cur_Area_H2
end
