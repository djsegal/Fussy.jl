"""
    Cost_HTS_Total(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Cost_HTS_Total(cur_solution=solve_magnet_equations())

  cur_Cost_HTS_Total = Vol_HTS_Total(cur_solution)

  cur_Cost_HTS_Total *= Tokamak.Price_HTS

  cur_Cost_HTS_Total /= Tokamak.Area_Tape()

  cur_Cost_HTS_Total

end
