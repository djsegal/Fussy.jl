"""
    cost_schedule(cur_table::CostTable)

Lorem ipsum dolor sit amet.
"""
function cost_schedule(cur_table::CostTable)
  CS = zeros(3, plant_life + construction_time)
  # row 1 is capital cost, row 2 is operations, and row 3 is decomissioning

  #%%% add in construction costs %%%%%%%%%%%%%%%%%%%%%
  CS[1,1:construction_time] = construction_distribution() * overnight_cost(cur_table)

  kW_h_per_year = econ_availability*econ_MW_e()*1000*3.15e7/3600
  CS[2,construction_time+1:end] = 540e3*econ_MW_e() + 3.5e-4*kW_h_per_year  +  Cryo_Operation()

  #decommissioning cost is scaled with lifetime and converted to 2017 dollars from 2009 $
  # WE ARE NEGLECTING FUEL COSTS! THATS FINE THOUGH -- 600*P_F ?

  CS
end
