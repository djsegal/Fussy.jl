"""
    bootstrap_gamma()

Lorem ipsum dolor sit amet.
"""
function bootstrap_gamma()
  cur_integral = function (rho)
    cur_value = b_theta(rho) ^ 2

    cur_value /= rho

    cur_value
  end

  cur_equation = function (x, F)
    cur_value = 4 * kappa

    cur_value /= ( 1 + kappa ^ 2 )

    cur_value *= QuadGK.quadgk(cur_integral, integral_zero, integral_one)[1]

    cur_value /= l_i

    cur_value -= 1.0

    cur_value
  end


  println(QuadGK.quadgk(cur_integral, integral_zero, integral_one))

  cur_l_i
end
