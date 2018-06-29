@symbol_func function v_te(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_T = T_rho(cur_reactor, cur_rho)

  cur_v = 1.88e7

  cur_v *= sqrt(cur_T)

  cur_v
end
