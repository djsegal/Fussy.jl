"""
    K_W()

Lorem ipsum dolor sit amet.
"""
function K_W()
  cur_K_W = 0.8

  cur_K_W /= 4

  cur_K_W /= pi ^ 2

  cur_kappa_P = kappa_P()

  cur_K_W *= cur_kappa_P

  cur_K_W /= epsilon_P()

  cur_denom = cur_kappa_P ^ 2
  cur_denom -= 1.0

  cur_denom *= ( 2 / pi )
  cur_denom += 1.0

  cur_K_W /= cur_denom

  cur_K_W *= K_F()

  cur_K_W
end
