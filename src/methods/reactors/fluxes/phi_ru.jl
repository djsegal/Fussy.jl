@symbol_func function phi_RU(cur_reactor::AbstractReactor)
  cur_phi = L_P(cur_reactor)

  cur_phi *= f_IN(cur_reactor) * cur_reactor.I_P

  cur_phi *= 1e6

  cur_phi
end
