"""
    K_DV()

Lorem ipsum dolor sit amet.
"""
function K_DV()
  cur_K_DV = 11.71

  cur_K_DV *= Q_kernel()

  cur_K_DV *= epsilon ^ 0.8
  cur_K_DV *= kappa ^ 2.2
  cur_K_DV *= f_DT ^ 2

  cur_K_DV *= geometry_scaling()

  cur_K_DV /= ( 1.0 + kappa ^ 2 ) ^ 1.2

  cur_K_DV
end
