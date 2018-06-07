@symbol_func function K_kappa(cur_reactor::AbstractReactor)
  cur_nu_n = cur_reactor.nu_n

  cur_nu_T = cur_reactor.nu_T

  cur_K = 0.4744

  cur_K *= ( 1 + cur_reactor.f_D )

  cur_K *= ( 1 + cur_nu_n )

  cur_K *= ( 1 + cur_nu_T )

  cur_K /= 1 + cur_nu_n + cur_nu_T

  cur_K *= cur_reactor.epsilon ^ 2

  cur_K *= cur_reactor.kappa_95

  cur_K *= g(cur_reactor)

  cur_K
end
