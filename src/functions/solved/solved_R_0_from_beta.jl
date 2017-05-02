"""
    solved_R_0_from_beta()

Lorem ipsum dolor sit amet.
"""
function solved_R_0_from_beta()
  left_part = K_beta()
  left_part *= ( T_k / 1u"keV" )
  left_part ^= 15

  right_part = -K_BR()
  right_part *= sqrt( T_k / 1u"keV" )
  right_part += ( sigma_v_hat / 1u"m^3/s" )

  right_part *= K_PB()

  right_part /= ( T_k / 1u"keV" ) ^ ( 4 // 100 )
  right_part /= ( sigma_v_hat / 1u"m^3/s" ) ^ ( 69 // 100 )
  right_part /= K_CD_denom ^ ( 96 // 100 )

  right_part ^= 100

  cur_R_0 = left_part
  cur_R_0 *= right_part
  cur_R_0 ^= ( 1 // 31 )

  cur_R_0 = calc_possible_values(cur_R_0)

  cur_R_0 *= 1u"m"

  cur_R_0
end
