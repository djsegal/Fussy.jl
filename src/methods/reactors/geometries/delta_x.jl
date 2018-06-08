@symbol_func function delta_x(cur_reactor::AbstractReactor)
  cur_delta = cur_reactor.delta_95

  cur_delta *= 1.5

  cur_delta
end
