"""
    P_n(R_0, I_M)

Lorem ipsum dolor sit amet.
"""
function P_n(R_0, I_M)
  cur_P_n = P_F(R_0, I_M)
  cur_P_n *= ( E_n / E_F() )

  cur_P_n
end
