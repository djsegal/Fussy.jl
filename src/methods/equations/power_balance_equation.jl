function power_balance_equation(cur_reactor::AbstractReactor)
  cur_B_power = cur_reactor.mode_scaling[:B]

  cur_R_power = alpha_R_star(cur_reactor)

  cur_I_power = alpha_I_star(cur_reactor)

  cur_G_T = G_PB(cur_reactor)

  cur_G_T /= K_PB(cur_reactor)

  cur_equation = Equation(
    cur_R_power,
    cur_B_power,
    cur_I_power,
    cur_G_T
  )

  cur_equation
end
