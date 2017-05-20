"""
    total_costs_per_year(cur_table::CostTable)

Lorem ipsum dolor sit amet.
"""
function total_costs_per_year(cur_table::CostTable)
  TCy = zeros(2, plant_life + construction_time)

  TCy[1,:] = sum(cost_schedule(cur_table),1)

  # discount cost per year
  for i = 1:(construction_time + plant_life)
    TCy[2,i] = TCy[1,i] / ( 1.0 + discount_rate )^i
  end

  TCy
end
