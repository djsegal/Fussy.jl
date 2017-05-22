"""
    Coil_Energy()

TF coil magnetic energy.
"""
function Coil_Energy()

  cur_Coil_Energy = Coil_Inductance()

  cur_Coil_Energy *= ( magnet_Imax() * 1000 ) ^ 2

  cur_Coil_Energy /= 2

  cur_Coil_Energy

end
