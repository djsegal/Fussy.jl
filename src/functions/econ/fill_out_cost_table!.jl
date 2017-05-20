"""
    fill_out_cost_table!(MCT::CostTable)

Lorem ipsum dolor sit amet.
"""
function fill_out_cost_table!(MCT::CostTable)

  #assume that FW, Be, VV, Blanket, and Thermal Shield are hollow elliptic tori

  cur_item = add_line_item!(MCT, "Magnets")

  cur_item.price_per = 1 #total cost of raw materials for magnets from Cost_Total from Magnets_2262_Final.m
  cur_item.fab_factor = 2 #arbitrary default FF

  cur_item = add_line_item!(MCT, "Blanket")

  #multiply volume of flibe needed for tank by two to account for HX etc
  cur_item.price_per = 154 * 1940 # $$/kg * kg/m^3 of Flibe

  cur_item.quantity = 2* 2*pi^2* ( R_0 / 1u"m" ) * ( ( ( a() / 1u"m" )+0.7004)*(( blanket_b() / 1u"m" )+0.7004) - ( ( a() / 1u"m" )+0.0804)*(( blanket_b() / 1u"m" )+0.0804) ) #volume
  cur_item.fab_factor = 1.8 #min set by arc for tank etc

  cur_item = add_line_item!(MCT, "First_Wall")

  cur_item.price_per = 29 * 19250 # $$/kg * kg/m^3 of tungsten
  cur_item.quantity = 2*pi^2* ( R_0 / 1u"m" ) * ( ( ( a() / 1u"m" )+.005)*(( blanket_b() / 1u"m" )+.005) -  ( a() / 1u"m" )*( blanket_b() / 1u"m" ) ) ##volume
  cur_item.fab_factor = 10 #arbitrary default FF

  cur_item = add_line_item!(MCT, "Be_multiplier")

  cur_item.price_per = 257 * 1850  # $$/kg * kg/m^3 of beryllium
  cur_item.quantity = 2*pi^2* ( R_0 / 1u"m" ) * ( ( ( a() / 1u"m" )+.0804)*(( blanket_b() / 1u"m" )+0.0804) - ( ( a() / 1u"m" )+0.0304)*(( blanket_b() / 1u"m" )+0.0304) ) #volume
  cur_item.fab_factor = 10 #arbitrary default FF

  cur_item = add_line_item!(MCT, "RF")

  cur_item.price_per = 1 # cost per kW given from RF team, don't have their code yet
  cur_item.quantity = 1 # number of kW given from RF team, don't have their code yet

  cur_item = add_line_item!(MCT, "BOP_turbine")

  cur_item.price_per = 360e6*(P_th()/2000)^.8*(eta_BOP/.6)

  cur_item = add_line_item!(MCT, "BOP_heatRej")

  cur_item.price_per =  87e6 * (1- eta_BOP) * P_th() / 2300

  cur_item = add_line_item!(MCT, "BOP_ElecGen")

  cur_item.price_per = 183e6(econ_MW_e()/1200)^.5

  cur_item = add_line_item!(MCT, "BOP_other")

  cur_item.price_per =  197e6*(econ_MW_e()/1000)^.8

  cur_item = add_line_item!(MCT, "MagnetPower")

  cur_item.price_per = 1 #Magnet code?
  cur_item.quantity = 1 #TO BE FILLED IN

  cur_item = add_line_item!(MCT, "Divertor")

  cur_item.price_per = divertor_material_cost()
  # want this to be the output from the
  #function divertor_material_cost which is in the divertor folder of the Final Code Blocks folder
  #the above function replaces cost.m that Will sent
  cur_item.fab_factor = 5 #arbitrary default FF

  cur_item = add_line_item!(MCT, "DivertorCool")

  cur_item.price_per = 50e6 #cst for any divertor

  cur_item = add_line_item!(MCT, "VacuumVessel")

  cur_item.price_per = 56 * 8192  #T$$/kg * kg/m^3 of inconel 718
  cur_item.quantity = 2*pi^2* ( R_0 / 1u"m" ) * ( ( ( a() / 1u"m" )+.0304)*(( blanket_b() / 1u"m" )+.0304) - ( ( a() / 1u"m" )+.005)*(( blanket_b() / 1u"m" )+.005) + ( ( a() / 1u"m" )+0.7258)*(( blanket_b() / 1u"m" )+0.7258) - ( ( a() / 1u"m" )+0.7004)*(( blanket_b() / 1u"m" )+0.7004) ) #volume
  cur_item.fab_factor = 20 #arbitrary default FF

  cur_item = add_line_item!(MCT, "MachineAssem")

  cur_item.price_per = 82.6e3 * 1.34 * 1552 * ( R_0 / 1u"m" )  / 6.2 * 1.10 #1.10 is the inflation conversion

  cur_item = add_line_item!(MCT, "Cryostat")

  cur_item.price_per = Cryostat_Cost() #from magnet code
  cur_item.fab_factor = 1.2 # arbitrary default FF

  cur_item = add_line_item!(MCT, "ThermalShields")

  cur_item.price_per = 26.4 * 3760 # T$$/kg * kg/m^3 of TiH2
  cur_item.quantity = 2*pi^2* ( R_0 / 1u"m" ) * ( ( ( a() / 1u"m" )+0.7258 + ( shield_thickness() / 1u"m" ))*(( blanket_b() / 1u"m" )+0.7258 + ( shield_thickness() / 1u"m" )) - ( ( a() / 1u"m" )+0.7258)*(( blanket_b() / 1u"m" )+0.7258) ) #volume
  cur_item.fab_factor = 5 #arbitrary default FF

  cur_item = add_line_item!(MCT, "VacuumPumpingandFueling")

  cur_item.price_per = 78e6*( calc_possible_values( P_F() / 1u"MW" ) /1758)^.8+78e6 #from aries

  cur_item = add_line_item!(MCT, "CoolingWater")

  cur_item = add_line_item!(MCT, "TritiumPlant")

  cur_item.price_per = 1 #TO BE FILLED IN
  cur_item.quantity = 1 #TO BE FILLED IN

  cur_item = add_line_item!(MCT, "Cryoplant")

  cur_item.price_per = Cryoplant_Cost() # from magnet code
  cur_item.fab_factor = 1.2 #arbitrary default FF

  cur_item = add_line_item!(MCT, "PowerSupplies")

  # cur_item.price_per = 4200e3
  # cur_item.quantity = econ_MW_e()
  # cur_item.fab_factor = 1

  cur_item = add_line_item!(MCT, "Buildings")

  cur_item.price_per = 1.292e6 #
  cur_item.quantity = econ_MW_e() #

  cur_item = add_line_item!(MCT, "WasteTreatment")

  cur_item = add_line_item!(MCT, "RadiologicalProtection")

  cur_item.price_per = 1.85e6

  cur_item = add_line_item!(MCT, "Land")

  cur_item.price_per = 90e3 #
  cur_item.quantity = econ_MW_e() #

end
