@symbol_func function a(cur_reactor::AbstractReactor)
  cur_a = cur_reactor.epsilon

  cur_a *= cur_reactor.R_0

  cur_a
end
