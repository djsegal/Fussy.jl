@symbol_func function P_E(cur_reactor::AbstractReactor)
  cur_P = P_T(cur_reactor)

  cur_P *= cur_reactor.eta_T

  cur_P
end
