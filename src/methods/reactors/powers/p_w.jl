@symbol_func function P_W(cur_reactor::AbstractReactor)
  cur_P = K_W(cur_reactor)

  cur_P *= safe_symbol(cur_reactor, :n_bar) ^ 2

  cur_P *= safe_symbol(cur_reactor, :R_0)

  cur_P *= cur_reactor.sigma_v

  cur_P
end
