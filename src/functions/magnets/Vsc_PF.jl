"""
    Vsc_PF()

Lorem ipsum dolor sit amet.
"""
function Vsc_PF()

  cur_Vsc_PF = zeros(1, 10)

  cur_magnet_rpp = magnet_rpp()
  cur_magnet_a2PF = magnet_a2PF()
  cur_magnet_cj = magnet_cj()

  for i = 1:10

    cur_left_term = cur_magnet_rpp[i] + cur_magnet_a2PF[i]

    cur_right_term = cur_magnet_cj[i]

    cur_Vsc_PF[i] = ( cur_left_term + cur_right_term ).^2

    cur_Vsc_PF[i] -= ( cur_left_term - cur_right_term ).^2

    cur_Vsc_PF[i] /= 4

    cur_Vsc_PF[i] *= pi

    cur_Vsc_PF[i] *= magnet_PF_coil_length

  end

  cur_Vsc_PF

end
