function B_0_equation(cur_reactor::AbstractReactor, cur_value::Number)
  cur_G_T = cur_value

  cur_equation = Equation(0, 1, 0, cur_G_T)

  cur_equation
end
