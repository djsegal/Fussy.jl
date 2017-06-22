"""
    solved_R_0_from_beta()

Lorem ipsum dolor sit amet.
"""
function solved_R_0_from_beta()

  left_part = K_beta()
  left_part *= ( T_k / 1u"keV" )
  left_part ^= ( confinement_scaling["B_0"] )

  left_part ^= 100

  right_part = -K_BR()
  right_part *= sqrt( T_k / 1u"keV" )
  right_part += ( sigma_v_hat / 1u"m^3/s" )

  right_part *= -K_PB()

  right_part /= ( T_k / 1u"keV" ) ^ ( 2 * confinement_scaling["P"] - confinement_scaling["I_M"] - confinement_scaling["n_bar"] )
  right_part /= ( sigma_v_hat / 1u"m^3/s" ) ^ confinement_scaling["P"]
  right_part /= K_CD_denom ^ ( confinement_scaling["n_bar"] + 1 - 2 * confinement_scaling["P"] + confinement_scaling["I_M"] )

  right_part ^= 100

  cur_R_0 = left_part
  cur_R_0 *= right_part
  cur_R_0 ^= ( 1 // 31 )

  cur_R_0 = calc_possible_values(cur_R_0)

  cur_R_0 *= 1u"m"

  cur_R_0

end
