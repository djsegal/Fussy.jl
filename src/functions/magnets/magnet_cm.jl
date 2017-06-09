"""
    magnet_cm()

Lorem ipsum dolor sit amet.
"""
function magnet_cm()

  cm = Array{Any}(1, 10)

  cur_magnet_Frc = magnet_Frc()

  for p = 1:10

    cm[p] = abs( cur_magnet_Frc[p] )

    cm[p] /= 2

    cm[p] /= magnet_PF_coil_length

    cm[p] /= magnet_Sy

  end

  cm

end
