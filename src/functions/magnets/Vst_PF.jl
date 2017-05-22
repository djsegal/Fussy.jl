"""
    Vst_PF()

Lorem ipsum dolor sit amet.
"""
function Vst_PF()

  cur_Vst_PF = zeros(1,10)

  for i = 1:10
    cur_Vst_PF[i] = pi*((magnet_a2PF()[i]).^2 - ((magnet_rpp()[i] + magnet_a2PF()[i])/2 + magnet_cj()[i]/2).^2)*magnet_PF_coil_length +
      pi*(((magnet_rpp()[i] + magnet_a2PF()[i])/2 - magnet_cj()[i]/2).^2 - (magnet_rpp()[i]).^2)*magnet_PF_coil_length
  end

  cur_Vst_PF

end
