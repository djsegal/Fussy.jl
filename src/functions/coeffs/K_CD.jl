"""
    K_CD()

Lorem ipsum dolor sit amet.
"""
function K_CD()
  cur_K_CD = K_kernel()

  cur_K_CD *= K_CD_hat()

  cur_K_CD
end
