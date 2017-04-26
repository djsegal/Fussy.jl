"""
    K_DV()

Lorem ipsum dolor sit amet.
"""
function K_DV()
  cur_K_DV = 68.96

  cur_K_DV *= 5 + Q
  cur_K_DV /= 5 * Q

  cur_K_DV *= kappa ^ ( 7 // 2 )
  cur_K_DV *= N_G ^ 4
  cur_K_DV *= C_B() ^ 2

  cur_K_DV /= epsilon
  cur_K_DV /= h_parallel

  cur_K_DV *= ( 1u"MW" * 1u"T" )
  cur_K_DV /= 1u"m"

  cur_K_DV
end
