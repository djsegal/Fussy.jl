@symbol_func function G_PB(cur_reactor::AbstractReactor)
  cur_numerator = cur_reactor.T_bar

  cur_denominator = ( 1 - K_CD(cur_reactor) * cur_reactor.sigma_v )

  cur_denominator /= sqrt(cur_reactor.T_bar) ^ 3

  cur_denominator *= K_omega(cur_reactor)

  cur_denominator += K_P(cur_reactor) * cur_reactor.sigma_v

  cur_denominator -= K_BR(cur_reactor) * sqrt(cur_reactor.T_bar)

  cur_denominator ^= ( 1 - cur_reactor.mode_scaling[:P] )

  cur_G = cur_numerator

  cur_G /= cur_denominator

  cur_G
end
