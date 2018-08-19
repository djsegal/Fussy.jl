@symbol_func function K_omega(cur_reactor::AbstractReactor)
  cur_K = K_RP(cur_reactor)

  cur_K /= K_n(cur_reactor) ^ 2

  cur_K *= 1e6

  cur_K
end
