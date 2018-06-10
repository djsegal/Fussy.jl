@symbol_func function P_H(cur_reactor::AbstractReactor)
  cur_P = P_F(cur_reactor)

  cur_P /= cur_reactor.Q

  cur_P
end
