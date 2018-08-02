function I_P_from_beta_wall(cur_reactor::AbstractReactor)
  cur_B_power = cur_reactor.mode_scaling[:B]

  cur_R_power = alpha_R_star(cur_reactor)

  cur_I_power = alpha_I_star(cur_reactor)

  cur_I = K_PB(cur_reactor)

  cur_I /= G_PB(cur_reactor)

  cur_I *= K_TB(cur_reactor) ^ cur_R_power

  cur_I *= cur_reactor.T_bar ^ cur_R_power

  ( cur_I > 0 ) || return NaN

  cur_I ^= ( 1 / ( cur_B_power - cur_R_power ) )

  cur_I *= K_TB(cur_reactor)

  cur_I /= K_WL(cur_reactor)

  cur_I *= cur_reactor.T_bar

  cur_I /= cur_reactor.sigma_v ^ ( 1/3 )

  cur_super_power = ( 2 / 3 ) * 1.0

  cur_super_power -= ( cur_I_power / ( cur_B_power - cur_R_power ) )

  cur_super_power ^= -1

  cur_I ^= cur_super_power

  cur_I
end
