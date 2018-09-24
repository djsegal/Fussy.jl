function heat_equation(cur_reactor::AbstractReactor)
  cur_G_T = K_DV(cur_reactor)

  cur_G_T *= cur_reactor.sigma_v ^ (1/3.2)

  cur_equation = Equation(1, 0, -1, cur_G_T)

  cur_equation
end
