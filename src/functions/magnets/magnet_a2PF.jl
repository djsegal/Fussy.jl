"""
    magnet_a2PF()

Lorem ipsum dolor sit amet.
"""
function magnet_a2PF()

  a2PF = zeros(1, 10)

  cur_magnet_cj = magnet_cj()
  cur_magnet_rpp = magnet_rpp()
  cur_magnet_Frc = magnet_Frc()

  for p = 1:10

    a2PF[p] = abs( cur_magnet_Frc[p] )

    a2PF[p] /= 2

    a2PF[p] /= magnet_PF_coil_length

    a2PF[p] /= magnet_Sy

    a2PF[p] += cur_magnet_rpp[p]

    a2PF[p] += cur_magnet_cj[p]

  end

  a2PF

end
