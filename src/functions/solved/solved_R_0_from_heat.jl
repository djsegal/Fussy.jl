"""
    solved_R_0_from_heat()

Lorem ipsum dolor sit amet.
"""
function solved_R_0_from_heat()
  cur_R_0 = -K_nu()
  cur_R_0 *= sqrt( T_k / 1u"keV" )
  cur_R_0 += ( sigma_v_hat / 1u"m^3/s" )

  cur_R_0 *= K_DV()
  cur_R_0 /= ( h_parallel / ( 1u"MW" / 1u"m^2" ) )
  cur_R_0 ^= ( 10 // 32 )

  cur_R_0 *= ( T_k / 1u"keV" )
  cur_R_0 /= K_CD_denom

  cur_R_0 = calc_possible_values(cur_R_0)

  cur_R_0 *= 1u"m"

  cur_R_0
end
