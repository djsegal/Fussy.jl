"""
    lcoe(cur_table::CostTable)

Lorem ipsum dolor sit amet.
"""
function lcoe(cur_table::CostTable)

  # units are dollars per MW-hr

  cur_lcoe = sum(total_costs_per_year(cur_table)[2,:])

  cur_lcoe /= sum(MWh_electric_per_year()[2,:])

  cur_lcoe

end
