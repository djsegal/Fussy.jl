@symbol_func function P_ohmic(cur_reactor::AbstractReactor)
  cur_P = cur_reactor.I_P ^ 2

  cur_P *= ( 1 - f_CD(cur_reactor) )

  cur_P *= R_P(cur_reactor)

  cur_P *= 1e6

  cur_P
end
