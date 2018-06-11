@symbol_func function R_P(cur_reactor::AbstractReactor)
  cur_R = K_RP(cur_reactor)

  cur_R /= cur_reactor.R_0

  cur_R /= cur_reactor.T_bar ^ (3/2)

  cur_R
end
