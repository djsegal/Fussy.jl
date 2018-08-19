function I_P_from_R_0_kink(cur_reactor::AbstractReactor, cur_value::Number)
  cur_B_power = cur_reactor.mode_scaling[:B]

  cur_R_power = alpha_R_star(cur_reactor)

  cur_I_power = alpha_I_star(cur_reactor)

  cur_I = G_PB(cur_reactor)

  cur_I /= K_PB(cur_reactor)

  cur_I /= K_KF(cur_reactor) ^ cur_B_power

  cur_I *= cur_value ^ ( cur_B_power - cur_R_power )

  ( cur_I > 0 ) || return NaN

  cur_I ^= ( 1 / ( cur_I_power + cur_B_power ) )

  cur_I
end

