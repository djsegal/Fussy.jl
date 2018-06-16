@symbol_func function V_loop(cur_reactor::AbstractReactor)
  cur_V = R_P(cur_reactor)

  cur_V *= cur_reactor.I_P

  cur_V *= f_IN(cur_reactor)

  cur_V *= 1e6

  cur_V
end
