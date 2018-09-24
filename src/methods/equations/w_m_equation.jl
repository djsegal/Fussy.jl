function W_M_equation(cur_reactor::AbstractReactor, cur_value::Number)
  cur_G_T = cur_value

  cur_G_T /= K_WM(cur_reactor)

  cur_equation = Equation(3, 2, 0, cur_G_T)

  cur_equation
end
