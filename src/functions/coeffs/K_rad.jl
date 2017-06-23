"""
    K_rad()

Lorem ipsum dolor sit amet.
"""
function K_rad()
  cur_K_rad = enable_bremsstrahlung ? 0.1056 : 0.0

  cur_K_rad *= ( 1 + nu_n ) ^ 2
  cur_K_rad *= ( 1 + nu_T ) ^ (1/2)
  cur_K_rad /= 1 + 2 * nu_n + (1/2) * nu_T

  cur_K_rad *= Z_eff
  cur_K_rad *= epsilon ^ 2
  cur_K_rad *= kappa

  cur_K_rad
end
