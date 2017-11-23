"""
    b_theta(rho, cur_gamma)

Lorem ipsum dolor sit amet.
"""
function b_theta(rho, cur_gamma)
  cur_b_theta = ( 1 - rho ^ 2 )
  cur_b_theta *= cur_gamma
  cur_b_theta += 1

  cur_b_theta *= exp( cur_gamma * rho ^ 2 )
  cur_b_theta -= ( 1 + cur_gamma )

  cur_b_theta /= rho
  cur_b_theta /= ( exp(cur_gamma) - ( 1 + cur_gamma ) )

  cur_b_theta
end
