"""
    K_B()

Lorem ipsum dolor sit amet.
"""
function K_B()
  cur_K_B = 4.913

  cur_K_B *= 1 + kappa ^ 2
  cur_K_B /= 2

  cur_K_B *= epsilon ^ (5/2)
  cur_K_B *= C_B()

  cur_K_B
end
