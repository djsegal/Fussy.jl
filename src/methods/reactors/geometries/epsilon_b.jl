@symbol_func function epsilon_b(cur_reactor::AbstractReactor)
  cur_epsilon = a(cur_reactor)

  cur_epsilon += b(cur_reactor)

  cur_epsilon /= safe_symbol(cur_reactor, :R_0)

  cur_epsilon
end
