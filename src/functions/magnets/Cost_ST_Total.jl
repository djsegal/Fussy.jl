"""
    Cost_ST_Total(cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Cost_ST_Total(cur_solution=solve_magnet_equations())

  cur_Cost_ST_Total = Vol_ST_Total(cur_solution)

  cur_Cost_ST_Total *= Price_St

  cur_Cost_ST_Total *= 8000

  cur_Cost_ST_Total

end
