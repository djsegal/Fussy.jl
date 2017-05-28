"""
    magnet_a2PF()

Lorem ipsum dolor sit amet.
"""
function magnet_a2PF()

  a2PF = zeros(1, 10)

  cur_magnet_cj = magnet_cj()
  cur_magnet_rpp = magnet_rpp()
  cur_magnet_cm = magnet_cm()

  for p = 1:10

    a2PF[p] = cur_magnet_cj[p]

    a2PF[p] += cur_magnet_cm[p]

    a2PF[p] /= +2

    a2PF[p] += cur_magnet_rpp[p]

  end

  a2PF

end
