function kink_equation(cur_reactor::AbstractReactor)
  cur_G_T = K_KF(cur_reactor)

  cur_equation = Equation(1, 1, -1, cur_G_T)

  cur_equation
end
