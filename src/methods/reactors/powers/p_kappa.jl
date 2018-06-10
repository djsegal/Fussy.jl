@symbol_func function P_kappa(cur_reactor::AbstractReactor)
  cur_P = K_kappa(cur_reactor)

  cur_P *= cur_reactor.R_0 ^ 3

  cur_P *= cur_reactor.n_bar

  cur_P *= cur_reactor.T_bar

  cur_P /= tau_E(cur_reactor)

  cur_P
end
