@symbol_func function P_L(cur_reactor::AbstractReactor)
  cur_P = P_alpha(cur_reactor)

  cur_P += P_H(cur_reactor)

  cur_P += P_ohmic(cur_reactor)

  cur_P -= P_BR(cur_reactor)

  cur_P
end
