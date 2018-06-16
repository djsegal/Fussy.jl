@symbol_func function beta_P(cur_reactor::AbstractReactor)
  cur_beta = 101325.0

  cur_beta *= 2

  cur_beta *= 4 * cur_reactor.pi * 1e-7

  cur_beta *= p_bar(cur_reactor)

  cur_beta /= B_P(cur_reactor) ^ 2

  cur_beta
end
