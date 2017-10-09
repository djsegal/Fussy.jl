"""
    K_kappa()

Lorem ipsum dolor sit amet.
"""
function K_kappa()
  cur_K_kappa = 0.475

  cur_K_kappa *= 1 + nu_n
  cur_K_kappa *= 1 + nu_T
  cur_K_kappa /= 1 + nu_n + nu_T

  cur_K_kappa *= 1 + f_DT

  cur_K_kappa *= epsilon ^ 2
  cur_K_kappa *= kappa

  cur_K_kappa *= geometry_scaling()

  cur_K_kappa
end
