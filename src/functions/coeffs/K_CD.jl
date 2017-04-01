"""
    K_CD()

Lorem ipsum dolor sit amet.
"""
function K_CD()
  cur_K_CD = 278.3

  cur_K_CD *= eta_CD
  cur_K_CD *= epsilon^2
  cur_K_CD *= kappa
  cur_K_CD /= Q

  cur_K_CD
end
