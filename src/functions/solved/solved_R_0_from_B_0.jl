"""
    solved_R_0_from_B_0(B_0)

Lorem ipsum dolor sit amet.
"""
function solved_R_0_from_B_0(solved_B_0)
  cur_numerator = -K_BR()
  cur_numerator *= sqrt( T_k / 1u"keV" )
  cur_numerator += calc_possible_values( sigma_v_hat / 1u"m^3/s" )

  cur_numerator *= -K_PB()

  cur_numerator *= ( solved_B_0 / 1u"T" ) ^ .15

  cur_numerator ^= ( 1 / 0.16 )

  println(cur_numerator)

  cur_denominator = ( T_k / 1u"keV" ) ^ .04

  cur_denominator *= ( sigma_v_hat / 1u"m^3/s" ) ^ .69
  cur_denominator *= K_CD_denom ^ .96

  cur_denominator = calc_possible_values(cur_denominator)

  cur_denominator ^= ( 1 / 0.16 )

  println(cur_denominator)

  cur_R_0 = cur_numerator / cur_denominator

  cur_R_0 = calc_possible_values(cur_R_0)

  cur_R_0 *= 1u"m"

  cur_R_0
end
