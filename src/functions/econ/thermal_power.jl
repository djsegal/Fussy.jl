"""
    thermal_power()

Lorem ipsum dolor sit amet.
"""
function thermal_power()

  # S_n + S_Li = 5.4 * S_alpha [eq 4.32, jeff book]

  cur_left_term = P_alpha()

  cur_left_term *= 5.4

  cur_left_term += P_BR()

  cur_left_term += P_kappa()

  cur_P_in_E = P_H()

  cur_P_in_E /= eta_RF

  cur_P_in_E /= eta_a

  cur_right_term = cur_P_in_E

  cur_right_term *= ( 1.0 - eta_a )

  cur_right_term *= eta_RF

  cur_thermal_power = cur_left_term

  cur_thermal_power += cur_right_term

  cur_thermal_power /= 1u"MW"

  cur_thermal_power = subs(
    cur_thermal_power, symbol_dict["tau_E"] ,
    ( confinement_time_from_scaling() / 1u"s" )
  )

  cur_thermal_power = calc_possible_values(cur_thermal_power)

  cur_thermal_power

end
