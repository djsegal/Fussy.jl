"""
    q_P()

Lorem ipsum dolor sit amet.
"""
function q_P()
  cur_q_P = -K_nu()

  cur_q_P *= sqrt( T_k / 1u"keV" )

  cur_q_P += ( sigma_v_hat / 1u"m^3/s" )

  cur_q_P *= K_DV()

  cur_q_P *= ( n_bar / 1u"n20" ) ^ 2

  cur_q_P *= ( R_0 / 1u"m" ) ^ 0.8

  cur_q_P *= ( I_M / 1u"MA" ) ^ 1.2

  cur_q_P *= 1u"GW"

  cur_q_P /= 1u"m^2"

  cur_q_P
end
