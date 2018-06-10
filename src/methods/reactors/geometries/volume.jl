@symbol_func function volume(cur_reactor::AbstractReactor)
  cur_volume = 2.0

  cur_volume *= cur_reactor.pi ^ 2

  cur_volume *= a(cur_reactor) ^ 2

  cur_volume *= cur_reactor.R_0

  cur_volume *= cur_reactor.kappa_95

  cur_volume
end
