@symbol_func function c(cur_reactor::AbstractReactor)
  cur_c = G_CO(cur_reactor)

  cur_c += G_CR(cur_reactor) * cur_reactor.R_0

  cur_c
end
