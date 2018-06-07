@symbol_func function K_PB(cur_reactor::AbstractReactor)
  cur_scaling = cur_reactor.mode_scaling

  cur_K = cur_reactor.H

  cur_K *= cur_scaling[:constant]

  cur_K /= K_law(cur_reactor)

  cur_K *= K_n(cur_reactor) ^ alpha_n_star(cur_reactor)

  cur_K /= K_P(cur_reactor) ^ cur_scaling[:P]

  cur_K /= K_F(cur_reactor) ^ cur_scaling[:P]

  cur_K *= cur_reactor.epsilon ^ cur_scaling[:a]

  cur_K *= kappa_tau(cur_reactor) ^ cur_scaling[:kappa]

  cur_K *= cur_reactor.A ^ cur_scaling[:A]

  cur_K
end
