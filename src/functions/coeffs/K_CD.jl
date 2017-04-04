"""
    K_CD()

Lorem ipsum dolor sit amet.
"""
function K_CD()
  cur_K_CD = K_I()

  cur_K_CD *= K_CD_hat()
  cur_K_CD /= K_B()

  cur_K_CD
end
