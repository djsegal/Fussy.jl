"""
    Cost_HTS_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

Lorem ipsum dolor sit amet.
"""
function Cost_HTS_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

  cur_Cost_HTS_Total = Vol_HTS_Total(cur_R_0, cur_n_bar, cur_I_M, cur_solution=cur_solution)

  cur_Cost_HTS_Total *= Price_HTS

  cur_Cost_HTS_Total /= Area_Tape()

  cur_Cost_HTS_Total

end
