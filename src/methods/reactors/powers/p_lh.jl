@symbol_func function P_LH(cur_reactor::AbstractReactor)
  cur_P = 0.0976

  cur_P *= cur_reactor.n_bar ^ 0.72

  cur_P *= cur_reactor.B_0 ^ 0.80

  cur_P *= surface_area(cur_reactor) ^ 0.94

  cur_P /= cur_reactor.A

  cur_P
end
