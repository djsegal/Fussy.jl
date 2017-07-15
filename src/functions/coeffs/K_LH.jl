"""
    K_LH()

Lorem ipsum dolor sit amet.
"""
function K_LH()
  cur_K_LH = K_kernel()

  cur_K_LH *= K_CD()

  cur_K_LH *= eta_CD

  cur_K_LH
end
