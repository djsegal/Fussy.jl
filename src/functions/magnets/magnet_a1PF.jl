"""
    magnet_a1PF()

Lorem ipsum dolor sit amet.
"""
function magnet_a1PF()

  a1PF = Array{Any}(1, 10)

  cur_magnet_cj = magnet_cj()
  cur_magnet_rpp = magnet_rpp()
  cur_magnet_cm = magnet_cm()

  for p = 1:10

    a1PF[p] = cur_magnet_cj[p]

    a1PF[p] += cur_magnet_cm[p]

    a1PF[p] /= -2

    a1PF[p] += cur_magnet_rpp[p]

  end

  a1PF

end
