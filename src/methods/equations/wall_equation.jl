function wall_equation(cur_reactor::AbstractReactor)
  cur_G_T = K_WL(cur_reactor)

  cur_G_T *= cur_reactor.sigma_v ^ (1/3)

  cur_equation = Equation(1, 0, -2/3, cur_G_T)

  cur_equation
end
