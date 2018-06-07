@symbol_func function K_F(cur_reactor::AbstractReactor)
  cur_K = 278.3

  cur_K *= cur_reactor.f_D ^ 2

  cur_K *= cur_reactor.epsilon ^ 2

  cur_K *= cur_reactor.kappa_95

  cur_K *= g(cur_reactor)

  cur_K
end
