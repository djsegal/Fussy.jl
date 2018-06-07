function steady_deck(cur_T_bar::AbstractSymbol)
  BaseReactor(
    T_bar = cur_T_bar,
    is_pulsed = false,

    H = 1.0,
    Q = 25.0,
    epsilon = 0.25,
    kappa_95 = 1.8,
    delta_95 = 0.4,
    nu_n = 0.4,
    nu_T = 1.1,
    Z_eff = 1.5,
    f_D = 0.9,
    A = 2.5,
    N_G = 0.9,
    gamma = 1.96078,
    eta_T = 0.352,
    eta_RF = 0.4,

    max_beta_N = 0.026,
    max_q_95 = 2.5,
    max_P_E = 1500.0,
    max_P_W = 2.5,
    max_q_DV = 10.0
  )
end
