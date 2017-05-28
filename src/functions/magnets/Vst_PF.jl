"""
    Vst_PF()

Lorem ipsum dolor sit amet.
"""
function Vst_PF()

  cur_Vst_PF = zeros(1, 10)

  cur_magnet_a1PF = magnet_a1PF()
  cur_magnet_a2PF = magnet_a2PF()
  cur_magnet_cj = magnet_cj()

  for i = 1:10

    cur_left_part = cur_magnet_a1PF[i] + cur_magnet_a2PF[i]

    cur_right_part = cur_magnet_cj[i]

    cur_Vst_PF[i] = ( cur_left_part - cur_right_part ) ^ 2

    cur_Vst_PF[i] -= ( cur_left_part + cur_right_part ) ^ 2

    cur_Vst_PF[i] /= 4

    cur_Vst_PF[i] += cur_magnet_a2PF[i] ^ 2

    cur_Vst_PF[i] -= cur_magnet_a1PF[i] ^ 2

    cur_Vst_PF[i] *= pi

    cur_Vst_PF[i] *= magnet_PF_coil_length

  end

  cur_Vst_PF

end
