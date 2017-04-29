"""
    K_BR()

Lorem ipsum dolor sit amet.
"""
function K_BR()
  cur_K_BR = enable_bremsstrahlung ? 3.795e-4 : 0

  cur_K_BR *= ( 1 + nu_n ) ^ 2
  cur_K_BR *= ( 1 + nu_T ) ^ (1/2)
  cur_K_BR /= 1 + 2 * nu_n + (1/2) * nu_T

  cur_K_BR *= 5 * Q
  cur_K_BR /= 5 + Q
  cur_K_BR *= Z_eff

  cur_K_BR
end
