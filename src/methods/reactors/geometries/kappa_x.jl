@symbol_func function kappa_x(cur_reactor::AbstractReactor)
  cur_kappa = cur_reactor.kappa_95

  cur_kappa *= 1.12

  cur_kappa
end
