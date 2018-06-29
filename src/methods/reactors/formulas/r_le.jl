@symbol_func function r_le(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_T = T_rho(cur_reactor, cur_rho)

  cur_r = 1.07e-4

  cur_r *= sqrt(cur_T)

  cur_r /= cur_reactor.B_0

  cur_r
end
