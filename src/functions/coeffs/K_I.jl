"""
    K_I()

Lorem ipsum dolor sit amet.
"""
function K_I()
  cur_K_I = 0.3183

  cur_K_I *= K_B()

  cur_K_I *= N_G
  cur_K_I /= epsilon ^ 2

  cur_K_I
end
