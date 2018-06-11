function act_1_deck(cur_T_bar::AbstractSymbol)
  BaseReactor(
    T_bar = cur_T_bar,
    is_pulsed = false,
    H = 1.65,
    Q = 42.5,
    epsilon = 0.25,
    kappa_95 = 1.964,
    delta_95 = 0.42,
    nu_n = 0.27,
    nu_T = 1.15,
    Z_eff = 2.11,
    f_D = 0.75,

    A = 2.5,
    l_i = 0.47,

    N_G = 1.0,
    eta_T = 0.575,
    eta_RF = 0.4,

    max_beta_N = 0.056,
    max_q_95 = 2.5,

    max_P_E = 1500.0,

    max_P_W = 2.45,
    max_q_DV = 13.7,

    b = 1.2,
    eta_CD = 0.188
  )
end
