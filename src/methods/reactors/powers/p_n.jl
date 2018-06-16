@symbol_func function P_n(cur_reactor::AbstractReactor)
  cur_P = P_F(cur_reactor)

  cur_P *= (4/5)

  cur_P
end
