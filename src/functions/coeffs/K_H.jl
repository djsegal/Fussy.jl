"""
    K_H()

Lorem ipsum dolor sit amet.
"""
function K_H()
  cur_K_H = 5.269e-3

  cur_K_H *= H

  q_kernel = 5 * Q
  q_kernel /= 5 + Q
  q_kernel ^= 0.69

  cur_K_H *= q_kernel

  cur_K_H *= kappa ^ ( 129 // 100 )
  cur_K_H *= N_G ^ ( 99 // 100 )
  cur_K_H *= C_B() ^ ( 96 // 100 )

  cur_K_H /= epsilon ^ ( 38 // 100 )

  cur_K_H
end
