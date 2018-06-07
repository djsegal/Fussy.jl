@symbol_func function G_PB(cur_reactor::AbstractReactor)
  cur_numerator = cur_reactor.T_bar

  cur_numerator *= cur_reactor.sigma_v ^ cur_reactor.mode_scaling[:P]

  cur_denominator = cur_reactor.sigma_v

  cur_denominator -= K_rad(cur_reactor) * sqrt(cur_reactor.T_bar)

  cur_G = cur_numerator

  cur_G /= cur_denominator

  cur_G
end
