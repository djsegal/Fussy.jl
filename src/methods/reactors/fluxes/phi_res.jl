@symbol_func function phi_res(cur_reactor::AbstractReactor)
  cur_phi = cur_reactor.C_ejima

  cur_phi *= cur_reactor.R_0

  cur_phi *= ( 4e-7 * cur_reactor.pi )

  cur_phi *= f_IN(cur_reactor) * cur_reactor.I_P

  cur_phi *= 1e6

  cur_phi
end
