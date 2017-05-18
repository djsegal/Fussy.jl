"""
    magnet_Frc()

Lorem ipsum dolor sit amet.
"""
function magnet_Frc()
  Frc = zeros(1,10)

  z1, z6, z2, z5, z3, z4 = magnet_zd_array()
  zp2, zp5, zp3, zp4 = magnet_zp_array()
  zm = 0

  zp = [z1 z2 z3 z4 z5 z6 zp2 zp5 zp3 zp4 zm]

  for i = 1:10
    for j = 1:10
      if j == i
        Frc[1,j] = Frc[1,j]+magnet_Frs(ItPF()[i])
      else
        Frc[1,j] = Frc[1,j] + magnet_Fr(magnet_rpp()[i],magnet_rpp()[j],zp[i],zp[j],ItPF()[i],ItPF()[j])
      end
    end
  end

  for i = 1:10
    Frc[1,i] = Frc[1,i] + magnet_Frp(magnet_rpp()[i],magnet_rpp()[11],zp[i],zp[11],ItPF()[i],ItPF()[11])
  end

  Frc
end
