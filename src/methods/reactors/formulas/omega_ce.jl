@symbol_func function omega_ce(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_omega = 1.76e11

  cur_omega *= cur_reactor.B_0

  cur_omega
end
