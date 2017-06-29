"""
    solved_R_0_from_B_0(B_0)

Lorem ipsum dolor sit amet.
"""
function solved_R_0_from_B_0(solved_B_0)
  cur_R_0 = -K_nu()
  cur_R_0 *= sqrt( T_k / 1u"keV" )
  cur_R_0 += ( sigma_v_hat / 1u"m^3/s" )

  cur_R_0 *= K_PB_legacy()

  cur_R_0 ^= +100

  cur_R_0 /= ( T_k / 1u"keV" ) ^ 4

  cur_R_0 /= ( sigma_v_hat / 1u"m^3/s" ) ^ 69
  cur_R_0 /= K_CD_denom ^ 96

  cur_R_0 *= ( solved_B_0 / 1u"T" ) ^ 15

  cur_R_0 ^= ( 1 // 16 )

  cur_R_0 = calc_possible_values(cur_R_0)

  cur_R_0 *= 1u"m"

  cur_R_0
end
