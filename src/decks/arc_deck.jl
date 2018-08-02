function arc_deck(cur_T_bar::AbstractSymbol=symbols(:T_bar); cur_kwargs...)
  cur_dict = Dict(
    :T_bar => cur_T_bar,
    :is_pulsed => false,
    :H => 1.8,
    :Q => 13.6,
    :epsilon => 0.3333,
    :kappa_95 => 1.84,

    :delta_95 => 0.333,

    :nu_n => 0.385,
    :nu_T => 0.929,
    :Z_eff => 1.2,

    :f_D => 0.9,
    :A => 2.5,

    :l_i => 0.67,
    :N_G => 0.67,
    :eta_T => 0.4,
    :eta_RF => 0.5,

    :max_beta_N => 0.0259,
    :max_q_95 => 2.5,
    :max_P_E => 1500.0,
    :max_P_W => 2.5,
    :max_q_DV => 10.0,

    :B_CS => 12.77,
    :k => 0.333,
    :sigma_CS => 660,
    :sigma_TF => 660,
    :J_CS => 50,
    :J_TF => 230,
    :C_ejima => 0.3,
    :tau_FT => 1.6e9,

    :eta_CD => 0.321,
    :wave_theta => 135.0,
    :eta_LH => 0.6
  )

  merge!(cur_dict, Dict(cur_kwargs))

  BaseReactor(cur_dict)
end
