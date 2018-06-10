@symbol_func function f_BS(cur_reactor::AbstractReactor)
  cur_f = K_BS(cur_reactor)

  cur_f *= cur_reactor.T_bar

  cur_f /= cur_reactor.I_P

  cur_f
end
