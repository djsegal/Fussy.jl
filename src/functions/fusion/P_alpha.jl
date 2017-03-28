"""
    P_alpha(R_0, I_M)

Lorem ipsum dolor sit amet.
"""
function P_alpha(R_0, I_M)
  cur_P_alpha = P_F(R_0, I_M)
  cur_P_alpha *= ( E_alpha / E_F() )

  cur_P_alpha
end
