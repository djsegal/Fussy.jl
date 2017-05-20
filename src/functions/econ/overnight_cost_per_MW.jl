"""
    overnight_cost_per_MW(cur_table::CostTable)

Lorem ipsum dolor sit amet.
"""
function overnight_cost_per_MW(cur_table::CostTable)
  cur_cost_per_MW = overnight_cost(cur_table)

  cur_cost_per_MW /= econ_MW_e()

  cur_cost_per_MW
end
