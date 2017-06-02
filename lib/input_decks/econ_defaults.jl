cost_W = 600000 # USD/m^3
cost_steel = 16000 # USD/m^3
cost_inconel = 66400 # USD/m^3

lcoe_wind = 73.6
lcoe_com_gas = 75.2
lcoe_coal = 95.1
lcoe_fission = 95.2
lcoe_solar = 125.3

N_cl = 26 # number of current leads (constant)

plant_life = 50 # lifetime of plant from start of construction to end of decomissioning -- years
construction_time = 7 # construction time -- years
discount_rate = 0.08 # discount rate for the project
econ_availability = 0.7
econ_efficency = 0.6

eta_BOP = 0.5 # we want to be able to sweep over this b/w 0.4 & 0.6

capital_cost_timeline = [ 0.1 , 0.25 , 0.3 , 0.25 , 0.1 ]

blanket_r_1 = 0.005u"m"
blanket_r_2 = 0.0304u"m"
blanket_r_3 = 0.0804u"m"
blanket_r_4 = 0.7004u"m"
blanket_r_5 = 0.7258u"m"
