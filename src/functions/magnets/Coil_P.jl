"""
    Coil_P()

Coil perimeter [m].
"""
function Coil_P()

  cur_Coil_P = magnet_L1()

  cur_Coil_P += magnet_L2()

  cur_Coil_P *= 2

  cur_Coil_P

end
