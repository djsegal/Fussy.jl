function B_0_from_kink(cur_reactor::AbstractReactor)
  cur_B_power = cur_reactor.mode_scaling[:B]

  cur_R_power = cur_reactor.mode_scaling[:R]

  cur_I_power = alpha_I_star(cur_reactor) + cur_R_power

  cur_B = K_PB(cur_reactor)

  cur_B /= G_PB(cur_reactor)

  cur_B *= cur_reactor.I_P ^ cur_I_power

  cur_B *= K_KF(cur_reactor) ^ cur_R_power

  cur_B *= 1

  cur_B ^= ( -1 / ( cur_B_power - cur_R_power ) )

  cur_B
end
