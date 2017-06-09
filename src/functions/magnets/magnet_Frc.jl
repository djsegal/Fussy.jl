"""
    magnet_Frc()

Lorem ipsum dolor sit amet.
"""
function magnet_Frc()

  Frc = Array{Any}(1, 10)

  fill!(Frc, 0.0)

  cur_ItPF = ItPF()
  cur_zpp = magnet_zpp()
  cur_rpp = magnet_rpp()

  for i = 1:10
    for j = 1:10
      if j == i
        Frc[1,j] += magnet_Frs(cur_ItPF[i])
      else
        Frc[1,j] += magnet_Fr(cur_rpp[i],cur_rpp[j],cur_zpp[i],cur_zpp[j],cur_ItPF[i],cur_ItPF[j])
      end
    end
  end

  for i = 1:10
    Frc[1,i] += magnet_Frp(cur_rpp[i],cur_rpp[11],cur_zpp[i],cur_zpp[11],cur_ItPF[i],cur_ItPF[11])
  end

  Frc

end
