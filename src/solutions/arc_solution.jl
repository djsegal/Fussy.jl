function arc_solution()
  cur_T = 14.0

  cur_reactor = arc_deck(cur_T)

  cur_reactor.n_bar = 1.3
  cur_reactor.I_P = 7.8

  cur_reactor.R_0 = 3.3
  cur_reactor.B_0 = 9.2

  cur_reactor.P_F = 525
  cur_reactor.f_BS = 0.63

  cur_reactor.beta_N = cur_reactor.max_beta_N
  cur_reactor.q_95 = 7.2

  cur_reactor
end
