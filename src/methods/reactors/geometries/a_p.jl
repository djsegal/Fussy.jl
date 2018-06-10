@symbol_func function a_P(cur_reactor::AbstractReactor)
  cur_a = 1.04

  cur_a *= a(cur_reactor)

  cur_a
end
