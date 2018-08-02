function scylla_deck(cur_T_bar::AbstractSymbol=symbols(:T_bar); cur_kwargs...)
  cur_dict = Dict(
    :T_bar => cur_T_bar,
    :H => 1.2,
    :Q => 25.0,
    :epsilon => 0.3,
    :kappa_95 => 1.8,
    :delta_95 => 0.35,
    :nu_n => 0.4,
    :nu_T => 1.1,
    :Z_eff => 1.75,
    :f_D => 0.9,
    :A => 2.5,
    :l_i => 0.6718,
    :N_G => 0.9,
    :eta_T => 0.4,
    :eta_RF => 0.5,
    :tau_FT => 7200.0,
    :C_ejima => 0.3,
    :max_beta_N => 0.028,
    :max_q_95 => 2.5,
    :max_P_E => 3000.0,
    :max_P_W => 3.0,
    :max_q_DV => 10.0,
    :B_CS => 21.44,
    :sigma_CS => 600,
    :sigma_TF => 300,
    :J_CS => 50,
    :J_TF => 200,
    :k => 0.4,
    :eta_CD => 0.2,
    :wave_theta => 135.0,
    :eta_LH => 0.6
  )

  merge!(cur_dict, Dict(cur_kwargs))

  BaseReactor(cur_dict)
end
