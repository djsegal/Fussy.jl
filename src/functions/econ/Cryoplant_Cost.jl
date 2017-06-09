"""
    Cryoplant_Cost(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=nothing)

Cost of cryoplant scaled to various heat loads, scaled to 4.5K and estimated using Green's Formula.
"""
function Cryoplant_Cost(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=nothing)

  if cur_solution == nothing
    cur_R_0 *= 1u"m"
    cur_n_bar *= 1u"n20"
    cur_I_M *= 1u"MA"

    cur_solution = solve_magnet_equations(cur_R_0, cur_n_bar, cur_I_M)
  end

  cur_Cryoplant_Cost = 2.6e6

  cur_Cryoplant_Cost *= magnet_Q_total(cur_R_0, cur_n_bar, cur_I_M, cur_solution=cur_solution) ^ 0.63

  cur_Cryoplant_Cost

end
