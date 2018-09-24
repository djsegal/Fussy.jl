function beta_equation(cur_reactor::AbstractReactor)
  cur_G_T = K_TB(cur_reactor)

  cur_G_T *= cur_reactor.T_bar

  cur_equation = Equation(1, 1, 0, cur_G_T)

  cur_equation
end
