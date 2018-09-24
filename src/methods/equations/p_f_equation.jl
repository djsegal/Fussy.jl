function P_F_equation(cur_reactor::AbstractReactor, cur_value::Number)
  cur_G_T = cur_value

  cur_G_T /= K_F(cur_reactor)

  cur_G_T /= K_n(cur_reactor) ^ 2

  cur_G_T /= cur_reactor.sigma_v

  cur_equation = Equation(-1, 0, 2, cur_G_T)

  cur_equation
end
