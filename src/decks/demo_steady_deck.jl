function demo_steady_deck(cur_T_bar::AbstractSymbol=symbols(:T_bar); cur_kwargs...)
  cur_dict = Dict(
    :T_bar => cur_T_bar,
    :is_pulsed => false,
    :H => 1.4,
    :Q => 24.46,
    :epsilon => 0.385,
    :kappa_95 => 1.800,
    :delta_95 => 0.333,
    :nu_n => 0.3972,
    :nu_T => 0.9187,
    :Z_eff => 4.708,
    :f_D => 0.7366,
    :A => 2.856,
    :l_i => 0.900,
    :N_G => 1.2,
    :eta_T => 0.5742,
    :eta_RF => 0.5,
    :tau_FT => 1e6,
    :C_ejima => 0.4,
    :max_beta_N => 0.038,
    :max_q_95 => 2.5,
    :max_P_E => 8000.0,
    :max_P_W => 8.0,
    :max_q_DV => 10.0,
    :B_CS => 12.85,
    :sigma_CS => 800,
    :sigma_TF => 800,
    :J_CS => 150,
    :J_TF => 24.7,
    :k => 0.216,
    :eta_CD => 0.4152,
    :wave_theta => 135.0,
    :eta_LH => 0.6,
    :ignored_limits => [:heat, :pcap]
  )

  merge!(cur_dict, Dict(cur_kwargs))

  BaseReactor(cur_dict)
end
