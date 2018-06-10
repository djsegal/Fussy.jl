@symbol_func function P_F(cur_reactor::AbstractReactor)
  cur_P = K_F(cur_reactor)

  cur_P *= cur_reactor.R_0 ^ 3

  cur_P *= cur_reactor.n_bar ^ 2

  cur_P *= cur_reactor.sigma_v

  cur_P
end
