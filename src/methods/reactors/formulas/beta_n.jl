@symbol_func function beta_N(cur_reactor::AbstractReactor)
  cur_beta = 4.027e-2

  cur_beta *= cur_reactor.epsilon

  cur_beta *= cur_reactor.R_0

  cur_beta *= cur_reactor.n_bar

  cur_beta *= cur_reactor.T_bar

  cur_beta /= cur_reactor.B_0

  cur_beta /= cur_reactor.I_P

  cur_beta *= ( 1 + cur_reactor.f_D )

  cur_beta *= ( 1 + cur_reactor.nu_n )

  cur_beta *= ( 1 + cur_reactor.nu_T )

  cur_beta /= ( 1 + cur_reactor.nu_n + cur_reactor.nu_T )

  cur_beta
end
