@symbol_func function epsilon_b(cur_reactor::AbstractReactor)
  cur_epsilon = a(cur_reactor)

  cur_epsilon += cur_reactor.b

  cur_epsilon /= cur_reactor.R_0

  cur_epsilon
end
