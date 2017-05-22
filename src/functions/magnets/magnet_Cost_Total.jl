"""
    magnet_Cost_Total(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function magnet_Cost_Total(cur_solution=solve_magnet_equations())

  cur_magnet_Cost_Total = Cost_HTS_Total(cur_solution)

  cur_magnet_Cost_Total += Cost_ST_Total(cur_solution)

  cur_magnet_Cost_Total

end
