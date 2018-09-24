@symbol_func function K_nT(cur_reactor::AbstractReactor)
  cur_K = 0.1581

  cur_K *= ( 1 + cur_reactor.f_D )

  cur_K *= ( 1 + cur_reactor.nu_n )

  cur_K *= ( 1 + cur_reactor.nu_T )

  cur_K /= ( 1 + cur_reactor.nu_n + cur_reactor.nu_T )

  cur_K
end
