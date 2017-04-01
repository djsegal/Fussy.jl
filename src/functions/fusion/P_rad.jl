"""
    P_rad()

Lorem ipsum dolor sit amet.
"""
function P_rad()
  cur_P_rad = K_rad()

  cur_P_rad *= ( n_bar / 1u"n20" ) ^ 2
  cur_P_rad *= ( T_k / 1u"keV" ) ^ (1/2)
  cur_P_rad *= ( R_0 / 1u"m" ) ^ 3

  cur_P_rad *= 1u"MW"

  cur_P_rad
end
