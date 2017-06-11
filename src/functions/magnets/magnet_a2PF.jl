@doc """
    magnet_a2PF(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_a2PF(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  a2PF = Array{Any}(1, 10)

  cur_magnet_cj = magnet_cj(cur_R_0, cur_n_bar, cur_I_M)
  cur_magnet_rpp = magnet_rpp()
  cur_magnet_cm = magnet_cm(cur_R_0, cur_n_bar, cur_I_M)

  for p = 1:10

    a2PF[p] = cur_magnet_cj[p]

    a2PF[p] += cur_magnet_cm[p]

    a2PF[p] /= +2

    a2PF[p] += cur_magnet_rpp[p]

  end

  a2PF

end
