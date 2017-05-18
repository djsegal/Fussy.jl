"""
    Area_Cu()

Lorem ipsum dolor sit amet.
"""
function Area_Cu()
  Turns = WP_d() * WP_w()

  #Determine Copper Stablizer Dimensions
  Tcs = 60 # lowest current sharing temperature
  R1 = ( R_0 / 1u"m" )-magnet_inner_radius()-magnet_material_thickness()/2 # Radius from center of CS to TF straight leg
  R2 = ( R_0 / 1u"m" )+magnet_inner_radius()+magnet_material_thickness()/2 # Radius from center of CS to TF outter D
  Ro = (R1*R2)^0.5
  K = 0.5*log(R2/R1)
  Coil_Inductance = (standard_mu_0*Turns^2*Ro*K^2)*(besseli(0,K) + 2*besseli(1,K) + besseli(2,K))/2 # TF coil inductance
  Coil_Energy = 0.5*Coil_Inductance*(magnet_Imax()*1000)^2 # TF coil magnetic energy
  Cu_Cp = (T) -> -0.000015917952141*T^4 + 0.001659188093121*T^3 - 0.003303875802231*T^2 - 0.076191481557999*T # Specific heat of copper as func of temperature
  Cu_Rho = 8950 # Density of copper
  cur_Area_Cu = (Coil_Energy/Cu_Cp(Tcs)/Cu_Rho/(150-Tcs)/Coil_P()/Turns)-(0.94*Area_HTS()) # Area of Copper per cable

  cur_Area_Cu
end
