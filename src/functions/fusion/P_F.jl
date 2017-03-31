"""
    P_F(I_M)

Lorem ipsum dolor sit amet.
"""
function P_F(I_M)
  cur_P_F = K_F() * n_bar(I_M)^2
  cur_P_F *= R_0^3
  cur_P_F *= sigma_v_hat()

  cur_P_F
end
