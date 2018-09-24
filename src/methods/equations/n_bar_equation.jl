function n_bar_equation(cur_reactor::AbstractReactor, cur_value::Number)
  cur_G_T = cur_value

  cur_G_T /= K_n(cur_reactor)

  cur_equation = Equation(-2, 0, 1, cur_G_T)

  cur_equation
end
