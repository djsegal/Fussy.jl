@symbol_func function K_VT(cur_reactor::AbstractReactor)
  cur_nu_n = cur_reactor.nu_n

  cur_nu_T = cur_reactor.nu_T

  cur_K = K_n(cur_reactor)

  cur_K *= cur_reactor.epsilon ^ 2

  cur_K *= g_p(cur_reactor)

  cur_K *= ( 1 + cur_reactor.f_D )

  cur_K *= ( 1 + cur_nu_n )

  cur_K *= ( 1 + cur_nu_T )

  cur_K /= 1 + cur_nu_n + cur_nu_T

  cur_K
end
