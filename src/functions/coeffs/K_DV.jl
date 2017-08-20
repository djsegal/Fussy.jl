"""
    K_DV()

Lorem ipsum dolor sit amet.
"""
function K_DV()
  cur_K_DV = 10.2

  cur_K_DV *= Q_kernel()

  cur_K_DV *= f_DT ^ 2
  cur_K_DV *= epsilon ^ 0.8
  cur_K_DV *= kappa ^ 2.2

  cur_denom = kappa ^ 2
  cur_denom -= 1

  cur_denom *= 2 / pi
  cur_denom += 1

  cur_denom ^= 1.2

  cur_K_DV /= cur_denom

  cur_K_DV
end
