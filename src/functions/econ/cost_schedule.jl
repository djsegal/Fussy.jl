"""
    cost_schedule(cur_table::CostTable)

Lorem ipsum dolor sit amet.
"""
function cost_schedule(cur_table::CostTable)

  cur_cost_schedule = zeros(3, plant_life + construction_time)

  # row 1 is capital cost
  # row 2 is operations & decomissioning

  construction_cost = construction_distribution()
  construction_cost *= overnight_cost(cur_table)

  cur_cost_schedule[1, 1:construction_time] = construction_cost

  # we are neglecting fuel costs!
  # thats fine though -- 600*p_f ?

  operations_cost = 540e3 * econ_MW_e()
  operations_cost += Cryo_Operation()

  cur_cost_schedule[2,construction_time+1:end] = operations_cost

  # decommissioning cost is scaled with lifetime
  # and converted to 2017 dollars from 2009

  decommision_cost = 3.5e-4
  decommision_cost *= econ_kW_h_per_year()
  decommision_cost *= 1.1

  cur_cost_schedule[2,construction_time+1:end] += decommision_cost

  cur_cost_schedule

end
