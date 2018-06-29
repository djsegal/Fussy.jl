@symbol_func function n_rho(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_n_bar = cur_reactor.n_bar

  cur_nu_n = cur_reactor.nu_n

  cur_n_rho = 1 - cur_rho ^ 2

  cur_n_rho ^= cur_nu_n

  cur_n_rho *= cur_n_bar

  cur_n_rho *= 1 + cur_nu_n

  cur_n_rho
end
