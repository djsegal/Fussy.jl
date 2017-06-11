@doc """
    magnet_Cost_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_Cost_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

  cur_magnet_Cost_Total = Cost_HTS_Total(cur_R_0, cur_n_bar, cur_I_M, cur_solution=cur_solution)

  cur_magnet_Cost_Total += Cost_ST_Total(cur_R_0, cur_n_bar, cur_I_M, cur_solution=cur_solution)

  cur_magnet_Cost_Total

end
