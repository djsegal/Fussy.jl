@symbol_func function omega_ce(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_omega = 1.76e11

  cur_omega *= B_rho(cur_reactor, cur_rho, cur_reactor.wave_theta)

  cur_omega
end
