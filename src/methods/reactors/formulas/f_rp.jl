@symbol_func function f_RP(cur_reactor::AbstractReactor)
  cur_f = Q_E(cur_reactor)

  cur_f += 1

  cur_f ^= -1

  cur_f
end
