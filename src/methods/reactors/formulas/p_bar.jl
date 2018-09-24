@symbol_func function p_bar(cur_reactor::AbstractReactor)
  cur_p = K_nT(cur_reactor)

  cur_p *= cur_reactor.n_bar

  cur_p *= cur_reactor.T_bar

  cur_p
end
