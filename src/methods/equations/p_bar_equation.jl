function p_bar_equation(cur_reactor::AbstractReactor, cur_value::Number)
  cur_G_T = cur_value

  cur_G_T /= K_n(cur_reactor)

  cur_G_T /= K_nT(cur_reactor)

  cur_G_T /= cur_reactor.T_bar

  cur_equation = Equation(-2, 0, 1, cur_G_T)

  cur_equation
end
