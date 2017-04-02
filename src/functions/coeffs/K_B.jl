"""
    K_B()

Lorem ipsum dolor sit amet.
"""
function K_B()
  cur_K_B = 4.913

  cur_K_B *= kappa ^ (5/4)
  cur_K_B *= epsilon ^ (5/2)
  cur_K_B *= K_C_B()

  cur_K_B
end
