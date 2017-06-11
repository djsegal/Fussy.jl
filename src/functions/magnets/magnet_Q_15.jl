@doc """
    magnet_Q_15(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

Total hydrogen cooling @ 15K [kW].
"""
@memoize function magnet_Q_15(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M; cur_solution=solve_magnet_equations())

  normalized_cold_mass = magnet_cold_mass(cur_R_0, cur_n_bar, cur_I_M, cur_solution=cur_solution)

  normalized_cold_mass /= magnet_standard_cold_mass

  cur_p_f_part = 14.4
  cur_p_f_part *= calc_possible_values( P_F() / 1u"MW" )
  cur_p_f_part /= 500

  cur_mass_part = 35.18 * normalized_cold_mass

  cur_Q_15 = cur_p_f_part

  cur_Q_15 += cur_mass_part
  cur_Q_15 += 12.4 * normalized_cold_mass
  cur_Q_15 += 6.4 * ( ( R_0 / 1u"m" ) * ( a() / 1u"m" )^2 / 24.8 )

  cur_q_part = cur_p_f_part + cur_mass_part
  cur_q_part *= 11.4
  cur_q_part /= ( 14.4 + 35.18 )

  cur_Q_15 += cur_q_part

  cur_Q_15 += 4 * ( N_cl / 30 )

  cur_Q_15

end
