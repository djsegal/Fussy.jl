"""
    P_T(R_0, I_M)

Lorem ipsum dolor sit amet.
"""
function P_T(R_0, I_M)
  cur_P_T = P_F(R_0, I_M)
  cur_P_T *= ( 1 + E_Li / E_F() )

  cur_P_T
end
