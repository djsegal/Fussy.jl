"""
    P_alpha(I_M)

Lorem ipsum dolor sit amet.
"""
function P_alpha(I_M)
  cur_P_alpha = P_F(I_M)
  cur_P_alpha *= ( E_alpha / E_F() )

  cur_P_alpha
end
