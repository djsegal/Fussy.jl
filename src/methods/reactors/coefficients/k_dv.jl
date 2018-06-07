@symbol_func function K_DV(cur_reactor::AbstractReactor)
  cur_K = _K_DV(cur_reactor)

  cur_K *= K_F(cur_reactor)

  cur_K *= K_n(cur_reactor) ^ 2

  cur_K /= cur_reactor.max_q_DV

  cur_K ^= (1/3.2)

  cur_K
end

@symbol_func function _K_DV(cur_reactor::AbstractReactor)
  cur_K = 27.75e-3

  cur_K /= cur_reactor.epsilon ^ 1.2

  cur_K *= K_P(cur_reactor)

  cur_K /= ( 1 + cur_reactor.kappa_95 ^ 2 ) ^ 0.6

  cur_K
end
