"""
    P_F()

Lorem ipsum dolor sit amet.
"""
function P_F()
  cur_P_F = K_F()

  cur_P_F *= ( n_bar / 1u"n20" ) ^ 2
  cur_P_F *= ( R_0 / 1u"m" ) ^ 3
  cur_P_F *= ( sigma_v_hat() / 1u"m^3/s" )

  cur_P_F *= 1u"MW"

  cur_P_F
end
