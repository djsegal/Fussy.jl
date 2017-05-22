"""
    magnet_cj()

Lorem ipsum dolor sit amet.
"""
function magnet_cj()

  cj = zeros(1, 10)

  cur_ItPF = ItPF()

  for p = 1:10
    cj[p] = abs(cur_ItPF[p])/(magnet_PF_coil_length*magnet_Jmax)
  end

  cj

end
