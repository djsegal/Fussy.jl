@doc """
    Vsc_PF(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function Vsc_PF(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_Vsc_PF = Array{Any}(1, 10)

  cur_magnet_a1PF = magnet_a1PF(cur_R_0, cur_n_bar, cur_I_M)
  cur_magnet_a2PF = magnet_a2PF(cur_R_0, cur_n_bar, cur_I_M)
  cur_magnet_cj = magnet_cj(cur_R_0, cur_n_bar, cur_I_M)

  for i = 1:10

    cur_left_term = cur_magnet_a1PF[i] + cur_magnet_a2PF[i]

    cur_right_term = cur_magnet_cj[i]

    cur_Vsc_PF[i] = ( cur_left_term + cur_right_term ).^2

    cur_Vsc_PF[i] -= ( cur_left_term - cur_right_term ).^2

    cur_Vsc_PF[i] /= 4

    cur_Vsc_PF[i] *= pi

    cur_Vsc_PF[i] *= magnet_PF_coil_length

  end

  cur_Vsc_PF

end
