function match(cur_reactor::AbstractReactor, cur_constraint::Symbol)
  @assert cur_reactor.constraint == :beta

  cur_func = function (cur_T_bar::Number)
    tmp_reactor = deepcopy(cur_reactor)

    tmp_reactor.T_bar = real(cur_T_bar)

    tmp_reactor.T_bar <= 0 && return NaN

    tmp_reactor.sigma_v = calc_sigma_v(tmp_reactor)
    isnan(tmp_reactor.sigma_v) && return NaN

    cur_error = tmp_reactor.I_P

    cur_error -= calc_I_P(tmp_reactor)

    tmp_I_P = calc_I_P(tmp_reactor, cur_constraint)

    cur_error = subs(
      cur_error,
      symbols(:R_0) => calc_R_0(tmp_reactor),
      symbols(:B_0) => calc_B_0(tmp_reactor),
      symbols(:I_P) => tmp_I_P
    )

    cur_error = real(float(cur_error))

    cur_error
  end

  _match(cur_reactor, cur_constraint, cur_func)
end

function _match(cur_reactor::AbstractReactor, cur_constraint::Symbol, cur_function::Function)
  cur_atol = 10 * eps()

  cur_T_bar_list = find_roots(
    cur_function, min_T_bar, max_T_bar,
    no_pts = no_pts_T_bar, reltol = 1e-1
  )

  isempty(cur_T_bar_list) && return nothing

  matched_reactor = nothing

  for (cur_index, cur_T_bar) in enumerate(cur_T_bar_list)
    isapprox(0.0, cur_T_bar, atol=cur_atol) && continue

    tmp_reactor = deepcopy(cur_reactor)

    tmp_reactor.T_bar = cur_T_bar

    tmp_reactor.sigma_v = calc_sigma_v(tmp_reactor)

    cur_I_P = calc_I_P(tmp_reactor, cur_constraint)

    isnan(cur_I_P) && continue

    tmp_reactor.I_P = float(cur_I_P)

    matched_reactor = update!(tmp_reactor)
  end

  matched_reactor
end
