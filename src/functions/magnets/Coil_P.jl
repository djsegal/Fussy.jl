"""
    Coil_P(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Coil perimeter [m].
"""
function Coil_P(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_Coil_P = magnet_L1()

  cur_Coil_P += magnet_L2(cur_R_0, cur_n_bar, cur_I_M)

  cur_Coil_P *= 2

  cur_Coil_P

end
