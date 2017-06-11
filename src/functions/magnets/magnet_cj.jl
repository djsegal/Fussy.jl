@doc """
    magnet_cj(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_cj(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cj = Array{Any}(1, 10)

  cur_ItPF = ItPF(cur_R_0, cur_n_bar, cur_I_M)

  for p = 1:10

    cj[p] = abs(cur_ItPF[p])

    cj[p] /= magnet_PF_coil_length

    cj[p] /= magnet_Jmax

  end

  cj

end
