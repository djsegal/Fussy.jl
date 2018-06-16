function act_2_deck(cur_T_bar::AbstractSymbol)
  BaseReactor(
    T_bar = cur_T_bar,
    is_pulsed = false,
    H = 1.22,
    Q = 25.0,
    epsilon = 0.25,
    kappa_95 = 1.964,
    delta_95 = 0.42,
    nu_n = 0.41,
    nu_T = 1.15,
    Z_eff = 2.12,
    f_D = 0.74,

    A = 2.5,
    rho_m = 0.0,

    N_G = 1.3,
    eta_T = 0.44,
    eta_RF = 0.4,

    max_beta_N = 0.026,
    max_q_95 = 2.5,

    max_P_E = 1500.0,

    max_P_W = 1.46,
    max_q_DV = 10.0,

    B_CS = 12.77,
    k = 0.333,
    sigma_CS = 660,
    sigma_TF = 660,
    J_CS = 50,
    J_TF = 230,
    C_ejima = 0.3,
    b = 1.2,
    tau_FT = 1.6e9,

    eta_CD = 0.256
  )
end
