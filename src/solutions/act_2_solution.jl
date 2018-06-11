function act_2_solution()
  cur_T = 17.8

  cur_reactor = act_2_deck(cur_T)

  cur_reactor.n_bar = 0.86
  cur_reactor.I_P = 13.98

  cur_reactor.R_0 = 9.75
  cur_reactor.B_0 = 8.75

  cur_reactor.P_F = 2637
  cur_reactor.f_BS = 0.77

  cur_reactor.beta_N = cur_reactor.max_beta_N
  cur_reactor.q_95 = 8.0

  cur_reactor
end
