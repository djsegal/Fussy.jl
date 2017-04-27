"""
    r_b_eq_hard_coded()

Lorem ipsum dolor sit amet.
"""
function r_b_eq_hard_coded()
  cur_r_b_eq = -K_BR()

  cur_r_b_eq *= sqrt( T_k / 1u"keV" )

  cur_r_b_eq += ( sigma_v_hat / 1u"m^3/s" )

  cur_r_b_eq *= -K_PB()

  cur_r_b_eq /= ( T_k / 1u"keV" ) ^ ( 4 // 100 )

  cur_r_b_eq /= ( sigma_v_hat / 1u"m^3/s" ) ^ ( 69 // 100 )

  cur_r_b_eq /= K_CD_denom ^ ( 96 // 100 )

  cur_r_b_eq *= ( B_0 / 1u"T" ) ^ ( 15 // 100 )

  cur_r_b_eq -= ( R_0 / 1u"m" ) ^ ( 16 // 100 )

  cur_r_b_eq
end
