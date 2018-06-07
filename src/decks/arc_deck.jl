function arc_deck(cur_T_bar::AbstractSymbol)
  BaseReactor(
    T_bar = cur_T_bar,
    is_pulsed = false,
    H = 1.8,
    Q = 13.6,
    epsilon = 0.3333,
    kappa_95 = 1.84,

    delta_95 = 0.333,

    nu_n = 0.385,
    nu_T = 0.929,
    Z_eff = 1.2,

    f_D = 0.9,
    A = 2.5,

    l_i = 0.67,
    N_G = 0.67,
    eta_T = 0.4,
    eta_RF = 0.5,

    max_beta_N = 0.0259,
    max_q_95 = 2.5,
    max_P_E = 1500.0,
    max_P_W = 2.5,
    max_q_DV = 10.0
  )
end
