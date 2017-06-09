"""
    Cost_HTS_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=nothing)

Lorem ipsum dolor sit amet.
"""
function Cost_HTS_Total(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=nothing)

  if cur_solution == nothing
    cur_R_0 *= 1u"m"
    cur_n_bar *= 1u"n20"
    cur_I_M *= 1u"MA"

    cur_solution = solve_magnet_equations(cur_R_0, cur_n_bar, cur_I_M)
  end

  cur_Cost_HTS_Total = Vol_HTS_Total(cur_R_0, cur_n_bar, cur_I_M, cur_solution=cur_solution)

  cur_Cost_HTS_Total *= Price_HTS

  cur_Cost_HTS_Total /= Area_Tape()

  cur_Cost_HTS_Total

end
