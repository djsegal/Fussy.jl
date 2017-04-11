"""
    K_H()

Lorem ipsum dolor sit amet.
"""
function K_H()
  cur_K_H = 4.527e-3

  cur_K_H *= H

  q_kernel = 5 * Q
  q_kernel /= 5 + Q

  cur_K_H *= q_kernel ^ 0.69

  cur_K_H *= kappa ^ 1.11
  cur_K_H *= N_G ^ 0.99
  cur_K_H *= C_B() ^ 0.96

  cur_K_H /= epsilon ^ 0.38

  cur_K_H
end
