"""
    magnet_a2PF()

Lorem ipsum dolor sit amet.
"""
function magnet_a2PF()

  cj = magnet_cj()

  a2PF = zeros(1,10)
  for p = 1:10
    a2PF[p] = (abs(magnet_Frc()[p])/2)/(magnet_PF_coil_length*magnet_Sy) + magnet_rpp()[p]+cj[p]
  end

  a2PF

end
