"""
    solved_B_0_from_wall()

Lorem ipsum dolor sit amet.
"""
function solved_B_0_from_wall()

  cur_numerator = K_W()
  cur_numerator *= calc_possible_values( sigma_v_hat / 1u"m^3/s" )
  cur_numerator *= ( T_k / 1u"keV" ) ^ 2

  cur_numerator /= calc_possible_values( K_CD_denom ) ^ 2
  cur_numerator ^= ( ( 2 * confinement_scaling["n_bar"] + 2 - confinement_scaling["R_0"] - confinement_scaling["P"] - confinement_scaling["a"] ) / 3 )

  cur_numerator *= ( T_k / 1u"keV" ) ^ ( 2 * confinement_scaling["P"] - confinement_scaling["I_M"] - confinement_scaling["n_bar"] )
  cur_numerator *= calc_possible_values( sigma_v_hat / 1u"m^3/s" ) ^ confinement_scaling["P"]
  cur_numerator *= calc_possible_values( K_CD_denom ) ^ ( confinement_scaling["n_bar"] + 1 - 2 * confinement_scaling["P"] + confinement_scaling["I_M"] )

  cur_numerator ^= 1

  cur_denominator = -K_BR()
  cur_denominator *= sqrt( T_k / 1u"keV" )

  cur_denominator += calc_possible_values( sigma_v_hat / 1u"m^3/s" )
  cur_denominator *= -K_PB()
  cur_denominator ^= 1

  println(cur_numerator)
  println(cur_denominator)
  println( 1 / ( 1 * confinement_scaling["B_0"] ) )
  cur_B_0 = cur_numerator ^ ( 1 / ( 1 * confinement_scaling["B_0"] ) )
  cur_B_0 /= cur_denominator ^ ( 1 / ( 1 * confinement_scaling["B_0"] ) )
  # cur_B_0 ^= ( 1 / ( 1 * confinement_scaling["B_0"] ) )

  # cur_B_0 = calc_possible_values(cur_B_0)

  cur_B_0 *= 1u"T"

  cur_B_0

end
