function f_BS_equation(cur_reactor::AbstractReactor, cur_value::Number)
  cur_G_T = K_BS(cur_reactor)

  cur_G_T *= cur_reactor.T_bar

  cur_G_T /= cur_value

  cur_equation = Equation(0, 0, 1, cur_G_T)

  cur_equation
end
