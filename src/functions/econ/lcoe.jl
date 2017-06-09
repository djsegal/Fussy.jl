"""
    lcoe(cur_table::CostTable)

Lorem ipsum dolor sit amet.
"""
function lcoe(cur_table::CostTable)

  # units are dollars per MW-hr

  cur_R_0 = cur_table.analyzed_solution["R_0"]
  cur_n_bar = cur_table.analyzed_solution["n_bar"]
  cur_I_M = cur_table.analyzed_solution["I_M"]
  cur_B_0 = cur_table.analyzed_solution["B_0"]

  cur_years_array = MWh_electric_per_year()[2,:]

  cur_years_array = map( cur_year ->
    magnet_subs( cur_year,
      cur_R_0 * 1u"m",
      cur_n_bar * 1u"n20",
      cur_I_M * 1u"MA",
      cur_B_0 * 1u"T"
    ),
    cur_years_array
  )

  cur_lcoe = sum(total_costs_per_year(cur_table)[2,:])

  cur_lcoe /= sum(cur_years_array)

  cur_lcoe

end
