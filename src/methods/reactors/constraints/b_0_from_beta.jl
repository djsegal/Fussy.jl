function B_0_from_beta(cur_reactor::AbstractReactor)
  cur_B_power = cur_reactor.mode_scaling[:B]

  cur_R_power = alpha_R_star(cur_reactor)

  cur_I_power = alpha_I_star(cur_reactor)

  cur_B = K_PB(cur_reactor)

  cur_B /= G_PB(cur_reactor)

  cur_B *= safe_symbol(cur_reactor, :I_P) ^ cur_I_power

  cur_B *= K_TB(cur_reactor) ^ cur_R_power

  cur_B *= cur_reactor.T_bar ^ cur_R_power

  cur_B ^= ( -1 / ( cur_B_power - cur_R_power ) )

  cur_B
end
