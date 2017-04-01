"""
    K_R()

Lorem ipsum dolor sit amet.
"""
function K_R()
  cur_K_R = 3.795e-4

  cur_K_R *= ( 1 + nu_n ) ^ 2
  cur_K_R *= ( 1 + nu_T ) ^ (1/2)
  cur_K_R /= 1 + 2 * nu_n + (1/2) * nu_T

  cur_K_R *= 5 * Q
  cur_K_R /= 5 + Q
  cur_K_R *= Z_eff

  cur_K_R
end
