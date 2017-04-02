"""
    K_C_B()

Lorem ipsum dolor sit amet.
"""
function K_C_B()
  cur_func = function (rho)
    numerator = rho ^ (5/2)
    numerator *= ( 1 - rho^2 ) ^ ( nu_n + nu_T - 1 )

    denominator = b_theta(rho)
    numerator / denominator
  end

  cur_K_C_B = ( 1 + nu_n )
  cur_K_C_B *= ( 1 + nu_T )
  cur_K_C_B *= ( nu_n + 0.055 * nu_T )
  cur_K_C_B *= QuadGK.quadgk(cur_func, 0, 1)[1]

  cur_K_C_B
end
