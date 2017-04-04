"""
    K_n()

Lorem ipsum dolor sit amet.
"""
function K_n()
  cur_K_n = K_I()

  cur_K_n *= K_I()
  cur_K_n /= K_B()

  cur_K_n
end
