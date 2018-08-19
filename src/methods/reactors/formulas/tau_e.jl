@symbol_func function tau_E(cur_reactor::AbstractReactor)
  cur_scaling = cur_reactor.mode_scaling

  cur_tau_E = cur_scaling[:constant]

  cur_tau_E *= cur_reactor.H

  cur_tau_E *= cur_reactor.I_P ^ cur_scaling[:I]

  cur_tau_E *= cur_reactor.R_0 ^ cur_scaling[:R]

  cur_tau_E *= a(cur_reactor) ^ cur_scaling[:a]

  cur_tau_E *= kappa_tau(cur_reactor) ^ cur_scaling[:kappa]

  cur_tau_E *= cur_reactor.n_bar ^ cur_scaling[:n]

  cur_tau_E *= cur_reactor.B_0 ^ cur_scaling[:B]

  cur_tau_E *= cur_reactor.A ^ cur_scaling[:A]

  cur_tau_E /= P_L(cur_reactor) ^ cur_scaling[:P]

  cur_tau_E
end
