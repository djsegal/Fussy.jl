"""
    solved_B_0_from_R_0()

Lorem ipsum dolor sit amet.
"""
function solved_B_0_from_R_0(solved_R_0)
  cur_B_0 = -K_BR()
  cur_B_0 *= sqrt( T_k / 1u"keV" )
  cur_B_0 += ( sigma_v_hat / 1u"m^3/s" )

  cur_B_0 *= K_PB()

  cur_B_0 ^= -100

  cur_B_0 *= ( T_k / 1u"keV" ) ^ 4

  cur_B_0 *= ( sigma_v_hat / 1u"m^3/s" ) ^ 69
  cur_B_0 *= K_CD_denom ^ 96

  cur_B_0 *= ( solved_R_0 / 1u"m" ) ^ 16

  cur_B_0 ^= ( 1 // 15 )

  cur_B_0 = calc_possible_values(cur_B_0)

  cur_B_0 *= 1u"T"

  cur_B_0
end
