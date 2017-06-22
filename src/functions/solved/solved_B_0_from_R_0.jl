"""
    solved_B_0_from_R_0()

Lorem ipsum dolor sit amet.
"""
function solved_B_0_from_R_0(solved_R_0)

  cur_B_0 = -K_BR()
  cur_B_0 *= sqrt( T_k / 1u"keV" )
  cur_B_0 += ( sigma_v_hat / 1u"m^3/s" )

  cur_B_0 *= K_PB()

  cur_B_0 ^= -1

  cur_B_0 *= ( T_k / 1u"keV" ) ^ ( 2 * confinement_scaling["P"] - confinement_scaling["I_M"] - confinement_scaling["n_bar"] )

  cur_B_0 *= ( sigma_v_hat / 1u"m^3/s" ) ^ confinement_scaling["P"]
  cur_B_0 *= K_CD_denom ^ ( confinement_scaling["n_bar"] + 1 - 2 * confinement_scaling["P"] + confinement_scaling["I_M"] )

  cur_B_0 *= ( solved_R_0 / 1u"m" ) ^ (
    2 * confinement_scaling["n_bar"] + 2 - confinement_scaling["R_0"] - confinement_scaling["P"] - confinement_scaling["a"]
  )

  cur_B_0 ^= ( 1 / (
      100 * confinement_scaling["B_0"]
    )
  )

  cur_B_0 = calc_possible_values(cur_B_0)

  cur_B_0 *= 1u"T"

  cur_B_0

end
