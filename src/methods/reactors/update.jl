function update!(cur_reactor::AbstractReactor)

  if !cur_reactor.is_good
    _NanizeReactor!(cur_reactor)
    return cur_reactor
  end

  cur_reactor.sigma_v = calc_sigma_v(cur_reactor)

  try

    cur_reactor.B_0 = convert(Real, calc_B_0(cur_reactor))
    cur_reactor.R_0 = convert(Real, calc_R_0(cur_reactor))
    cur_reactor.n_bar = convert(Real, calc_n_bar(cur_reactor))

  catch cur_error

    is_caught_error = isa(cur_error, InexactError)
    is_caught_error |= isa(cur_error, DomainError)
    is_caught_error || rethrow(cur_error)

    cur_reactor.is_good = false
    _NanizeReactor!(cur_reactor)

    return cur_reactor

  end

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

  cur_reactor.is_valid = true

  for (cur_limit, cur_variable) in secondary_params
    in(cur_limit, cur_reactor.ignored_limits) && continue

    cur_norm_symbol = Symbol("norm_$(cur_variable)")

    cur_norm_value = getfield(cur_reactor, cur_norm_symbol)

    cur_norm_value <= 1.001 && continue

    cur_reactor.is_valid = false
    break
  end

  cur_reactor.volume = volume(cur_reactor)
  cur_reactor.W_M = W_M(cur_reactor)

  cur_reactor.cost = cur_reactor.W_M / cur_reactor.P_F

  cur_reactor.resistance = R_P(cur_reactor)
  cur_reactor.voltage = V_loop(cur_reactor)
  cur_reactor.inductance = L_P(cur_reactor)

  cur_reactor.a = a(cur_reactor)
  cur_reactor.b = b(cur_reactor)

  try

    cur_reactor.c = c(cur_reactor)
    cur_reactor.d = d(cur_reactor)

    cur_reactor.R_CS = R_CS(cur_reactor)
    cur_reactor.h_CS = h_CS(cur_reactor)

    cur_reactor.is_pulsed &&
      ( @assert cur_reactor.R_CS >= 0 )

  catch cur_error

    is_caught_error = isa(cur_error, InexactError)
    is_caught_error |= isa(cur_error, DomainError)
    is_caught_error |= isa(cur_error, AssertionError)

    is_caught_error || rethrow(cur_error)

    cur_reactor.is_valid = false
    return cur_reactor

  end

  cur_reactor

end
