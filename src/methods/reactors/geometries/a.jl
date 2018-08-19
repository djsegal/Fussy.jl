@symbol_func function a(cur_reactor::AbstractReactor)
  cur_a = cur_reactor.epsilon

  cur_a *= safe_symbol(cur_reactor, :R_0)

  cur_a
end
