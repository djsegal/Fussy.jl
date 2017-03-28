"""
    b_theta()

Lorem ipsum dolor sit amet.
"""
function b_theta(rho)
  alpha = 1 / ( 1 - rho_m^2 )

  cur_b_theta = ( 1 + alpha * ( 1 - rho^2 ) )
  cur_b_theta *= exp( alpha * rho^2 )
  cur_b_theta -= ( 1 + alpha )
  cur_b_theta /= rho * ( exp(alpha) - ( 1 + alpha ) )

  cur_b_theta
end
