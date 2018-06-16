@symbol_func function cross_sectional_area(cur_reactor::AbstractReactor)
  cur_volume = cur_reactor.pi

  cur_volume *= a(cur_reactor) ^ 2

  cur_volume *= cur_reactor.kappa_95

  cur_volume *= g(cur_reactor)

  cur_volume
end
