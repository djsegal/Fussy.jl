function I_P_from_B_0(cur_reactor::AbstractReactor, cur_value::Number)
  cur_B_power = cur_reactor.mode_scaling[:B]

  cur_R_power = alpha_R_star(cur_reactor)

  cur_I_power = alpha_I_star(cur_reactor)

  cur_I = G_PB(cur_reactor)

  cur_I /= K_PB(cur_reactor)

  cur_I /= cur_value ^ cur_B_power

  cur_I /= safe_symbol(cur_reactor, :R_0) ^ cur_R_power

  cur_I ^= ( 1 / cur_I_power )

  cur_I
end
