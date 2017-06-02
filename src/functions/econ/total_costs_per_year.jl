"""
    total_costs_per_year(cur_table::CostTable)

Discount cost per year.
"""
function total_costs_per_year(cur_table::CostTable)

  total_years = construction_time + plant_life

  cur_cost = zeros(2, total_years)

  cur_cost[1,:] = sum(cost_schedule(cur_table), 1)

  for cur_year in 1:total_years

    cur_cost[2, cur_year] = cur_cost[1, cur_year]

    cur_cost[2, cur_year] /= ( 1.0 + discount_rate ) ^ cur_year

  end

  cur_cost

end
