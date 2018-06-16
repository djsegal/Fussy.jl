@symbol_func function phi_PF(cur_reactor::AbstractReactor)
  cur_phi = cur_reactor.R_0 ^ 2

  cur_phi -= ( R_CS(cur_reactor) + d(cur_reactor) ) ^ 2

  cur_phi *= cur_reactor.pi

  cur_phi *= B_V(cur_reactor)

  cur_phi
end
