@symbol_func function omega_pe(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_n = n_rho(cur_reactor, cur_rho)

  cur_omega = 5.64e11

  cur_omega *= sqrt(cur_n)

  cur_omega
end


