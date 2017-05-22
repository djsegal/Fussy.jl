"""
    magnet_Frc()

Lorem ipsum dolor sit amet.
"""
function magnet_Frc()

  Frc = zeros(1, 10)

  z1, z6, z2, z5, z3, z4 = magnet_zd_array()
  zp2, zp5, zp3, zp4 = magnet_zp_array()
  zm = 0

  zp = [z1 z2 z3 z4 z5 z6 zp2 zp5 zp3 zp4 zm]

  cur_ItPF = ItPF()
  cur_magnet_rpp = magnet_rpp()

  for i = 1:10
    for j = 1:10
      if j == i
        Frc[1,j] += magnet_Frs(cur_ItPF[i])
      else
        Frc[1,j] += magnet_Fr(cur_magnet_rpp[i],cur_magnet_rpp[j],zp[i],zp[j],cur_ItPF[i],cur_ItPF[j])
      end
    end
  end

  for i = 1:10
    Frc[1,i] += magnet_Frp(cur_magnet_rpp[i],cur_magnet_rpp[11],zp[i],zp[11],cur_ItPF[i],cur_ItPF[11])
  end

  Frc

end
