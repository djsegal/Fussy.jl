function act_1_deck(cur_T_bar::AbstractSymbol=symbols(:T_bar); cur_kwargs...)
  cur_dict = Dict(
    :T_bar => cur_T_bar,
    :is_pulsed => false,
    :H => 1.65,
    :Q => 42.5,
    :epsilon => 0.25,
    :kappa_95 => 2.1,
    :delta_95 => 0.4,
    :nu_n => 0.27,
    :nu_T => 1.15,
    :Z_eff => 2.11,
    :f_D => 0.75,

    :A => 2.5,
    :l_i => 0.35906,
    # :rho_m => .82,

    :N_G => 1.0,
    :eta_T => 0.575,
    :eta_RF => 0.4,

    :max_beta_N => 0.0427,
    :max_q_95 => 2.5,

    :max_P_E => 1500.0,

    :max_P_W => 2.45,
    :max_q_DV => 13.7,

    :B_CS => 12.77,
    :k => 0.333,
    :sigma_CS => 660,
    :sigma_TF => 660,
    :J_CS => 50,
    :J_TF => 230,
    :C_ejima => 0.3,
    :tau_FT => 1.6e9,

    :eta_CD => 0.188,
    :wave_theta => 135.0,
    :eta_LH => 0.6
  )

  merge!(cur_dict, Dict(cur_kwargs))

  BaseReactor(cur_dict)
end
