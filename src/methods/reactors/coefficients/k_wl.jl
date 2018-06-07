@symbol_func function K_WL(cur_reactor::AbstractReactor)
  cur_K = _K_WL(cur_reactor)

  cur_K *= K_n(cur_reactor) ^ 2

  cur_K /= cur_reactor.max_P_W

  cur_K ^= (1/3)

  cur_K
end

@symbol_func function _K_WL(cur_reactor::AbstractReactor)
  cur_kappa = kappa_P(cur_reactor)

  cur_epsilon = epsilon_P(cur_reactor)

  cur_denominator = cur_kappa ^ 2 - 1.0

  cur_denominator *= ( 2 / cur_reactor.pi )

  cur_denominator += 1

  cur_K = K_F(cur_reactor)

  cur_K /= 5.0

  cur_K /= cur_reactor.pi ^ 2

  cur_K *= cur_kappa

  cur_K /= cur_epsilon

  cur_K /= cur_denominator

  cur_K
end
