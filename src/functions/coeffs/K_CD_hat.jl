"""
    K_CD_hat()

Lorem ipsum dolor sit amet.
"""
function K_CD_hat()
  cur_K_CD = K_F()

  cur_K_CD *= eta_CD

  cur_K_CD /= Q

  cur_K_CD
end
