"""
    K_L()

Lorem ipsum dolor sit amet.
"""
function K_L()
  cur_K_L = 3.409e-3

  cur_K_L *= 1 + nu_n
  cur_K_L *= 1 + nu_T
  cur_K_L /= 1 + nu_n + nu_T

  cur_K_L *= 5 * Q
  cur_K_L /= 5 + Q

  cur_K_L
end
