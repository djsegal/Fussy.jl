@symbol_func function phi_CS(cur_reactor::AbstractReactor)
  cur_phi = cur_reactor.k

  cur_phi *= cur_reactor.B_0

  cur_phi *= sqrt( h_CS(cur_reactor) )

  cur_phi *= sqrt( G_LO(cur_reactor) )

  cur_phi *= sqrt( K_LP(cur_reactor) )

  cur_phi *= sqrt( cur_reactor.R_0 )

  cur_phi /= sqrt( 1e-7 )

  cur_phi
end
