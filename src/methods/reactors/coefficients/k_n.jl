@symbol_func function K_n(cur_reactor::AbstractReactor)
  cur_nu_n = cur_reactor.nu_n

  cur_K = 2.0

  cur_K *= cur_reactor.N_G

  cur_K /= sqrt(cur_reactor.pi) ^ 3

  cur_K /= cur_reactor.epsilon ^ 2

  cur_K *= gamma( cur_nu_n + 3/2 )

  cur_K /= gamma( cur_nu_n + 2.0 )

  cur_K
end
