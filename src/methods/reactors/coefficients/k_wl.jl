@symbol_func function K_WL(cur_reactor::AbstractReactor)
  cur_K = K_W(cur_reactor)

  cur_K *= K_n(cur_reactor) ^ 2

  cur_K /= cur_reactor.max_P_W

  cur_K ^= (1/3)

  cur_K
end
