@symbol_func function L_P(cur_reactor::AbstractReactor)
  cur_R = K_LP(cur_reactor)

  cur_R *= cur_reactor.R_0

  cur_R
end
