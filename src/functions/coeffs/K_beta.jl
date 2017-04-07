"""
    K_beta()

Lorem ipsum dolor sit amet.
"""
function K_beta()
  cur_K_beta = 2.563e-2

  cur_K_beta *= 1 + nu_n
  cur_K_beta *= 1 + nu_T
  cur_K_beta /= 1 + nu_n + nu_T

  cur_K_beta *= N_G
  cur_K_beta /= epsilon
  cur_K_beta /= beta_N

  cur_K_beta
end
