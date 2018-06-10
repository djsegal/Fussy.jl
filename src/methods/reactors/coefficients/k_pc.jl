@symbol_func function K_PC(cur_reactor::AbstractReactor)
  cur_K = K_F(cur_reactor)

  cur_K *= K_n(cur_reactor) ^ 2

  cur_K *= 1 + E_Li / E_F

  cur_K *= cur_reactor.eta_T

  cur_K /= cur_reactor.max_P_E

  cur_K
end
