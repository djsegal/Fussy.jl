function demo_pulsed_solution()
  cur_T = 13.065

  cur_reactor = demo_pulsed_deck(cur_T)

  cur_reactor.n_bar = 0.7983
  cur_reactor.I_P = 19.6

  cur_reactor.R_0 = 9.072
  cur_reactor.B_0 = 5.667

  cur_reactor.P_F = 2037

  cur_reactor.f_BS = 0.348
  cur_reactor.f_CD = 0.096
  cur_reactor.f_IN = 0.557

  cur_reactor.beta_N = cur_reactor.max_beta_N
  cur_reactor.q_95 = 3.247
  cur_reactor.P_W = 1.05

  cur_reactor.volume = 2502

  cur_reactor
end
