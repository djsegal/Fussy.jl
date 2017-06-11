@doc """
    magnet_cm(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_cm(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cm = Array{Any}(1, 10)

  cur_magnet_Frc = magnet_Frc(cur_R_0, cur_n_bar, cur_I_M)

  for p = 1:10

    cm[p] = abs( cur_magnet_Frc[p] )

    cm[p] /= 2

    cm[p] /= magnet_PF_coil_length

    cm[p] /= magnet_Sy

  end

  cm

end
