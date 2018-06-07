@symbol_func function K_TB(cur_reactor::AbstractReactor)
  cur_K = 4.027e-2

  cur_K *= K_n(cur_reactor)

  cur_K *= cur_reactor.epsilon

  cur_K /= cur_reactor.max_beta_N

  cur_K *= 1 + cur_reactor.f_D

  cur_K *= 1 + cur_reactor.nu_n

  cur_K *= 1 + cur_reactor.nu_T

  cur_K /= 1 + cur_reactor.nu_n + cur_reactor.nu_T

  cur_K
end
