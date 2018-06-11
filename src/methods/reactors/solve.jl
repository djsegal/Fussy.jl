function solve!(cur_reactor::AbstractReactor)
  cur_reactor.sigma_v = calc_sigma_v(cur_reactor)

  cur_I_P = NaN

  if !isnan(cur_reactor.sigma_v)
    cur_eq = calc_I_P(cur_reactor)

    if isa(cur_eq, SymEngine.Basic)
      cur_eq = subs(
        calc_I_P(cur_reactor),
        symbols(:R_0) => calc_R_0(cur_reactor),
        symbols(:B_0) => calc_B_0(cur_reactor)
      )

      cur_eq /= symbols(:I_P)

      cur_eq -= 1.0

      cur_I_P = _solve(cur_eq)
    else
      cur_I_P = cur_eq
    end
  end

  cur_reactor.is_good = !isnan(cur_I_P)

  cur_reactor.is_solved = true

  cur_reactor.I_P = cur_I_P

  cur_reactor.is_good && _add_solutions_to_reactor(cur_reactor)

  cur_reactor.is_good || _NanizeReactor!(cur_reactor)

  cur_reactor
end

function _solve(cur_eq::SymEngine.Basic, cur_min::Number=min_I_P, cur_max::Number=max_I_P, cur_depth::Int=0)
  ( cur_depth > 3 ) && return NaN

  cur_I_P = NaN

  try
    cur_I_P = fzero(cur_eq, cur_min, cur_max)
  catch cur_error
    cur_mid = mean([cur_min, cur_max])

    cur_I_P_bot = _solve(cur_eq, cur_min, cur_mid, cur_depth+1)
    cur_I_P_top = _solve(cur_eq, cur_mid, cur_max, cur_depth+1)

    if isnan(cur_I_P_bot)
      cur_I_P = cur_I_P_top
    elseif isnan(cur_I_P_top)
      cur_I_P = cur_I_P_bot
    else
      cur_I_P = min(cur_I_P_bot, cur_I_P_top)
    end
  end

  cur_I_P
end

function _add_solutions_to_reactor(cur_reactor::AbstractReactor)

  cur_reactor.B_0 = calc_B_0(cur_reactor)

  cur_reactor.R_0 = calc_R_0(cur_reactor)

  cur_reactor.n_bar = calc_n_bar(cur_reactor)

  cur_reactor.tau_E = tau_E(cur_reactor)
  cur_reactor.p_bar = p_bar(cur_reactor)
  cur_reactor.P_F = P_F(cur_reactor)

  cur_reactor.f_BS = f_BS(cur_reactor)
  cur_reactor.f_CD = f_CD(cur_reactor)
  cur_reactor.f_IN = f_IN(cur_reactor)

  cur_reactor.beta_N = beta_N(cur_reactor)
  cur_reactor.q_95 = q_95(cur_reactor)
  cur_reactor.q_DV = q_DV(cur_reactor)
  cur_reactor.P_E = P_E(cur_reactor)
  cur_reactor.P_W = P_W(cur_reactor)

  cur_reactor.norm_beta_N = beta_N(cur_reactor)
  cur_reactor.norm_q_95 = q_95(cur_reactor)
  cur_reactor.norm_q_DV = q_DV(cur_reactor)
  cur_reactor.norm_P_E = P_E(cur_reactor)
  cur_reactor.norm_P_W = P_W(cur_reactor)

  cur_reactor.norm_beta_N /= cur_reactor.max_beta_N
  cur_reactor.norm_q_95 /= cur_reactor.max_q_95
  cur_reactor.norm_q_DV /= cur_reactor.max_q_DV
  cur_reactor.norm_P_E /= cur_reactor.max_P_E
  cur_reactor.norm_P_W /= cur_reactor.max_P_W

  cur_reactor.norm_q_95 ^= -1

  # cur_reactor.cost = cost(cur_reactor)
  cur_reactor.volume = volume(cur_reactor)
  cur_reactor.W_M = W_M(cur_reactor)

  # cur_reactor.resistance = rho_spitzer(cur_reactor)
  # cur_reactor.voltage = V_L(cur_reactor)
  # cur_reactor.inductance = L_P(cur_reactor)

  cur_reactor.a = a(cur_reactor)

end
