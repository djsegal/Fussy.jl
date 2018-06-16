@symbol_func function L_P(cur_reactor::AbstractReactor)
  cur_L = K_LP(cur_reactor)

  cur_L *= cur_reactor.R_0

  cur_L
end
