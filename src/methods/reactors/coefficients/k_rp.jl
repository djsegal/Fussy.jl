@symbol_func function K_RP(cur_reactor::AbstractReactor)
  cur_epsilon = cur_reactor.epsilon

  cur_K = 5.6e-8

  cur_K *= cur_reactor.Z_eff

  cur_K /= cur_epsilon ^ 2

  cur_K /= kappa_x(cur_reactor)

  cur_K /= ( 1 - 1.31 * sqrt(cur_epsilon) + 0.46 * cur_epsilon )

  cur_K
end
