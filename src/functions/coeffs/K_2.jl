"""
    K_2()

Lorem ipsum dolor sit amet.
"""
function K_2()
  cur_K_2 = 2.59e-2

  cur_K_2 *= 1 + nu_n
  cur_K_2 *= 1 + nu_T
  cur_K_2 /= 1 + nu_n + nu_T

  cur_K_2 *= N_G
  cur_K_2 /= epsilon
  cur_K_2 /= beta_N

  cur_K_2
end
