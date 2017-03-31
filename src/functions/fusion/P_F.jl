"""
    P_F()

Lorem ipsum dolor sit amet.
"""
function P_F()
  cur_P_F = K_F() * n_bar^2
  cur_P_F *= ( R_0 / 1u"m" ) ^ 3
  cur_P_F *= sigma_v_hat()

  cur_P_F
end
