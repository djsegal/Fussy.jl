"""
    P_BR()

Lorem ipsum dolor sit amet.
"""
function P_BR()
  cur_P_BR = K_rad()

  cur_P_BR *= ( n_bar / 1u"n20" ) ^ 2
  cur_P_BR *= ( T_k / 1u"keV" ) ^ (1/2)
  cur_P_BR *= ( R_0 / 1u"m" ) ^ 3

  cur_P_BR *= 1u"MW"

  cur_P_BR
end
