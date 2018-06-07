function demo_solution()
  cur_T = 13.065

  cur_reactor = demo_deck(cur_T)

  cur_reactor.eta_CD = 0.2721

  cur_reactor.n_bar = 0.7983
  cur_reactor.I_P = 19.6

  cur_reactor.R_0 = 9.072
  cur_reactor.B_0 = 5.667

  cur_reactor.P_F = 2037
  cur_reactor.f_BS = 0.323

  cur_reactor.beta_N = cur_reactor.max_beta_N
  cur_reactor.q_95 = 3.247

  cur_reactor
end
