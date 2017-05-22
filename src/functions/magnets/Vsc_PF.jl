"""
    Vsc_PF()

Lorem ipsum dolor sit amet.
"""
function Vsc_PF()

  cur_Vsc_PF = zeros(1,10)

  for i = 1:10
    cur_Vsc_PF[i] = pi*(((magnet_rpp()[i] + magnet_a2PF()[i])/2 + magnet_cj()[i]/2).^2 - ((magnet_rpp()[i] + magnet_a2PF()[i])/2 - magnet_cj()[i]/2).^2)*magnet_PF_coil_length
  end

  cur_Vsc_PF

end
