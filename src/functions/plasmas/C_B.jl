"""
    C_B()

Lorem ipsum dolor sit amet.
"""
function C_B()
  cur_func = function (rho)
    cur_value = 1 - rho^2

    cur_value ^= nu_n + nu_T - 1

    cur_value *= rho ^ (5/2)

    cur_value /= b_theta(rho)

    cur_value
  end

  cur_C_B = ( 1 + nu_n )
  cur_C_B *= ( 1 + nu_T )
  cur_C_B *= ( nu_n + 0.055 * nu_T )
  cur_C_B *= QuadGK.quadgk(cur_func, 0, 1)[1]

  cur_C_B
end
