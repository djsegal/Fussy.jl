@symbol_func function kappa_P(cur_reactor::AbstractReactor)
  cur_kappa = 1.3

  cur_kappa *= cur_reactor.kappa_95

  cur_kappa
end
