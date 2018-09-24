function T_bar_equation(cur_reactor::AbstractReactor, cur_value::Number)
  cur_G_T = cur_value

  cur_G_T /= cur_reactor.T_bar

  cur_equation = Equation(0, 0, 0, cur_G_T)

  cur_equation
end
