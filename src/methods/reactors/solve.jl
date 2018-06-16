function solve!(cur_reactor::AbstractReactor)
  cur_reactor.sigma_v = calc_sigma_v(cur_reactor)

  cur_I_P = NaN

  if cur_reactor.T_bar > 0 && !isnan(cur_reactor.sigma_v)
    cur_eq = calc_I_P(cur_reactor)

    if isa(cur_eq, SymEngine.Basic)
      cur_eq = subs(
        calc_I_P(cur_reactor),
        symbols(:R_0) => calc_R_0(cur_reactor),
        symbols(:B_0) => calc_B_0(cur_reactor)
      )

      cur_eq /= symbols(:I_P)

      cur_eq -= 1.0

      cur_lambda = lambdify(cur_eq)

      cur_func = function (work_I_P)
        cur_value = cur_lambda(complex(float(work_I_P)))
        iszero(imag(cur_value)) || return float(-max_I_P)
        return Real(cur_value)
      end

      cur_I_P = _solve(cur_reactor, cur_func)
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

function _solve(cur_reactor::AbstractReactor, cur_eq::Function)
  cur_I_P_list = Roots.find_zeros(cur_eq, min_I_P, max_I_P)

  bad_indices = []

  for (cur_index, cur_I_P) in enumerate(cur_I_P_list)
    iszero(cur_I_P) && ( push!(bad_indices, cur_index) ; continue )

    tmp_reactor = deepcopy(cur_reactor)

    tmp_reactor.I_P = cur_I_P
    tmp_reactor.B_0 = convert(Real, calc_B_0(tmp_reactor))
    tmp_reactor.R_0 = convert(Real, calc_R_0(tmp_reactor))
    tmp_reactor.n_bar = convert(Real, calc_n_bar(tmp_reactor))

    ( f_BS(tmp_reactor) > 0 ) || ( push!(bad_indices, cur_index) ; continue )
    ( f_CD(tmp_reactor) > 0 ) || ( push!(bad_indices, cur_index) ; continue )
    ( f_IN(tmp_reactor) > 0 ) || ( push!(bad_indices, cur_index) ; continue )
  end

  deleteat!(cur_I_P_list, bad_indices)

  isempty(cur_I_P_list) && return NaN

  return first(cur_I_P_list)
end

function _add_solutions_to_reactor(cur_reactor::AbstractReactor)

  try

    cur_reactor.B_0 = convert(Real, calc_B_0(cur_reactor))
    cur_reactor.R_0 = convert(Real, calc_R_0(cur_reactor))
    cur_reactor.n_bar = convert(Real, calc_n_bar(cur_reactor))

  catch cur_error

    is_caught_error = isa(cur_error, InexactError)
    is_caught_error |= isa(cur_error, DomainError)
    is_caught_error || rethrow(cur_error)

    cur_reactor.is_good = false
    return

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

  # cur_reactor.cost = cost(cur_reactor)
  cur_reactor.volume = volume(cur_reactor)
  cur_reactor.W_M = W_M(cur_reactor)

  # cur_reactor.resistance = rho_spitzer(cur_reactor)
  # cur_reactor.voltage = V_L(cur_reactor)
  # cur_reactor.inductance = L_P(cur_reactor)

  cur_reactor.a = a(cur_reactor)

end
