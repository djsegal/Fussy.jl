function demo_steady_solution()
  cur_T = 18.067

  cur_reactor = demo_steady_deck(cur_T)

  cur_reactor.n_bar = 0.8746
  cur_reactor.I_P = 21.627

  cur_reactor.R_0 = 7.500
  cur_reactor.B_0 = 5.627

  cur_reactor.P_F = 3255

  cur_reactor.f_BS = 0.611
  cur_reactor.f_CD = 1.00 - cur_reactor.f_BS
  cur_reactor.f_IN = 0.00

  cur_reactor.beta_N = cur_reactor.max_beta_N
  cur_reactor.q_95 = 4.405
  cur_reactor.P_W = 1.911

  cur_reactor.volume = 2217

  cur_reactor
end
