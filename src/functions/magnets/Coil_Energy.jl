"""
    Coil_Energy(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

TF coil magnetic energy.
"""
function Coil_Energy(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_Coil_Energy = Coil_Inductance(cur_R_0, cur_n_bar, cur_I_M)

  cur_Coil_Energy *= ( magnet_Imax() * 1000 ) ^ 2

  cur_Coil_Energy /= 2

  cur_Coil_Energy

end
