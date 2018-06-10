@symbol_func function q_95(cur_reactor::AbstractReactor)
  cur_q = 5.0

  cur_q *= cur_reactor.B_0

  cur_q *= a(cur_reactor) ^ 2

  cur_q *= _f_q(cur_reactor)

  cur_q /= cur_reactor.R_0

  cur_q /= cur_reactor.I_P

  cur_q
end
