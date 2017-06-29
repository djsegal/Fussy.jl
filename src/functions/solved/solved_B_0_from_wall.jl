"""
    solved_B_0_from_wall()

Lorem ipsum dolor sit amet.
"""
function solved_B_0_from_wall()
  cur_numerator = K_W()
  cur_numerator *= ( sigma_v_hat / 1u"m^3/s" )
  cur_numerator *= ( T_k / 1u"keV" ) ^ 2

  cur_numerator /= K_CD_denom ^ 2
  cur_numerator ^= ( 16 // 3 )

  cur_numerator *= ( T_k / 1u"keV" ) ^ 4
  cur_numerator *= ( sigma_v_hat / 1u"m^3/s" ) ^ 69
  cur_numerator *= K_CD_denom ^ 96

  cur_denominator = -K_nu()
  cur_denominator *= sqrt( T_k / 1u"keV" )

  cur_denominator += ( sigma_v_hat / 1u"m^3/s" )
  cur_denominator *= K_PB_legacy()
  cur_denominator ^= 100

  cur_B_0 = cur_numerator
  cur_B_0 /= cur_denominator
  cur_B_0 ^= ( 1 // 15 )

  cur_B_0 = calc_possible_values(cur_B_0)

  cur_B_0 *= 1u"T"

  cur_B_0
end
