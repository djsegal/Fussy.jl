function act_1_solution()
  cur_T = 20.6

  cur_reactor = act_1_deck(cur_T)

  cur_reactor.eta_CD = 0.188

  cur_reactor.n_bar = 1.3
  cur_reactor.I_P = 10.95

  cur_reactor.R_0 = 6.25
  cur_reactor.B_0 = 6.0

  cur_reactor.P_F = 1813
  cur_reactor.f_BS = 0.91

  cur_reactor.beta_N = cur_reactor.max_beta_N
  cur_reactor.q_95 = 4.5

  cur_reactor
end
