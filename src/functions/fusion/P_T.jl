"""
    P_T()

Lorem ipsum dolor sit amet.
"""
function P_T()
  cur_P_T = P_F()
  cur_P_T *= ( 1 + E_Li / E_F() )

  cur_P_T
end
