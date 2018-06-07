@symbol_func function K_rad(cur_reactor::AbstractReactor)
  cur_K = K_BR(cur_reactor)

  cur_K /= K_F(cur_reactor)

  cur_K /= K_P(cur_reactor)

  cur_K
end
