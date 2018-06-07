@symbol_func function K_law(cur_reactor::AbstractReactor)
  cur_K = K_kappa(cur_reactor)

  cur_K /= K_F(cur_reactor)

  cur_K /= K_P(cur_reactor)

  cur_K
end
