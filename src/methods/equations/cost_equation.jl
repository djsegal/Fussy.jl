function cost_equation(cur_reactor::AbstractReactor, cur_value::Number)
  cur_G_T = cur_value

  cur_G_T *= K_F(cur_reactor)

  cur_G_T *= cur_reactor.sigma_v

  cur_G_T /= K_WM(cur_reactor)

  cur_G_T ^= (1/2)

  cur_G_T *= K_n(cur_reactor)

  cur_equation = Equation(2, 1, -1, cur_G_T)

  cur_equation
end
