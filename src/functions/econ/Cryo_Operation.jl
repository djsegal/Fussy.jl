"""
    Cryo_Operation(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

Cost of power @ 0.1 \$/kWhr to power the cryoplant annually.
"""
function Cryo_Operation(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

  cur_magnet_Q_total = magnet_Q_total(cur_R_0, cur_n_bar, cur_I_M, cur_solution=cur_solution)

  cur_Cryo_Operation = cur_magnet_Q_total

  cur_Cryo_Operation /= ( 15 / ( 300 - 15 ) )

  cur_Cryo_Operation /= ( 0.141 * cur_magnet_Q_total ^ 0.26 )

  cur_Cryo_Operation *= ( 24 * 365 ) # hours per year

  cur_Cryo_Operation *= 0.1 # $/kWhr

  cur_Cryo_Operation *= 1 + discount_rate

  cur_Cryo_Operation

end
