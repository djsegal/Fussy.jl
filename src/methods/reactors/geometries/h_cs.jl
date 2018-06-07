@symbol_func function h_CS(cur_reactor::AbstractReactor)
  cur_h = cur_reactor.kappa_95 * a(cur_reactor)

  cur_h += cur_reactor.b

  cur_h += c(cur_reactor)

  cur_h *= 2

  cur_h
end
