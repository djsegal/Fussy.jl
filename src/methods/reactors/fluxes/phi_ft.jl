@symbol_func function phi_FT(cur_reactor::AbstractReactor)
  cur_phi = V_loop(cur_reactor)

  cur_phi *= cur_reactor.tau_FT

  cur_phi
end
