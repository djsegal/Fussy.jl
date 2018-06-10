@symbol_func function P_alpha(cur_reactor::AbstractReactor)
  cur_P = P_F(cur_reactor)

  cur_P /= 5

  cur_P
end
