function match(cur_reactor::AbstractReactor, cur_constraint::Symbol, cur_value::Union{Void, Number}=nothing)
  ( cur_value == nothing ) && @assert cur_reactor.constraint == :beta

  cur_func = function (cur_T_bar::Number)
    tmp_reactor = deepcopy(cur_reactor)

    tmp_reactor.T_bar = real(cur_T_bar)

    tmp_reactor.T_bar <= 0 && return NaN

    tmp_reactor.sigma_v = calc_sigma_v(tmp_reactor)

    isnan(tmp_reactor.sigma_v) && return NaN

    if cur_value != nothing
      @assert cur_constraint == :R_0 || cur_constraint == :B_0
      setfield!(tmp_reactor, cur_constraint, cur_value)
    end

    cur_error = calc_I_P(tmp_reactor)

    cur_error /= symbols(:I_P)

    cur_error -= 1.0

    if cur_value == nothing
      tmp_I_P = calc_I_P(tmp_reactor, cur_constraint)
    else
      tmp_I_P = calc_I_P(tmp_reactor, cur_constraint, cur_value)
    end

    if cur_value == nothing
      cur_error = subs(
        cur_error,
        symbols(:R_0) => calc_R_0(tmp_reactor),
        symbols(:B_0) => calc_B_0(tmp_reactor),
        symbols(:I_P) => tmp_I_P
      )
    else
      isa(cur_error, SymEngine.Basic) && ( cur_error = subs(cur_error, symbols(:I_P) => tmp_I_P) )
      isa(cur_error, SymEngine.Basic) && ( cur_error = subs(cur_error, symbols(:R_0) => calc_R_0(tmp_reactor)) )
      isa(cur_error, SymEngine.Basic) && ( cur_error = subs(cur_error, symbols(:B_0) => calc_B_0(tmp_reactor)) )
      isa(cur_error, SymEngine.Basic) && ( cur_error = subs(cur_error, symbols(:R_0) => calc_R_0(tmp_reactor)) )
      isa(cur_error, SymEngine.Basic) && ( cur_error = subs(cur_error, symbols(:I_P) => tmp_I_P) )
    end

    cur_error = real(float(cur_error))

    cur_error
  end

  matched_reactors = _match(cur_reactor, cur_func, cur_constraint, cur_value)
  matched_reactors = filter!(work_reactor -> work_reactor.is_good, matched_reactors)

  isempty(matched_reactors) && return nothing

  if length(matched_reactors) > 1
    work_reactors = filter(work_reactor -> work_reactor.is_valid, matched_reactors)

    if !isempty(work_reactors)
      if length(work_reactors) > 1
        custom_log("Bad match! Too many reactors!")
        custom_log(cur_constraint, " - ", cur_value)
        custom_log(work_reactors)
      end

      min_index = indmin(map(work_reactor -> work_reactor.cost, work_reactors))
      return work_reactors[min_index]
    end
  end

  first(matched_reactors)
end

function _match(cur_reactor::AbstractReactor, cur_function::Function, cur_constraint::Symbol, cur_value::Union{Void, Number}=nothing)
  cur_atol = 10 * eps()

  cur_T_bar_list = find_roots(
    cur_function, min_T_bar, max_T_bar,
    no_pts = Int(ceil(no_pts_T_bar/2))+1, reltol = 1e-2, abstol = 1e-4
  )

  isempty(cur_T_bar_list) && return []

  matched_reactors = []

  for (cur_index, cur_T_bar) in enumerate(cur_T_bar_list)
    isapprox(0.0, cur_T_bar, atol=cur_atol) && continue

    tmp_reactor = deepcopy(cur_reactor)

    tmp_reactor.T_bar = cur_T_bar

    tmp_reactor.sigma_v = calc_sigma_v(tmp_reactor)

    if cur_value == nothing
      cur_I_P = calc_I_P(tmp_reactor, cur_constraint)
    else
      setfield!(tmp_reactor, cur_constraint, cur_value)
      cur_I_P = calc_I_P(tmp_reactor, cur_constraint, cur_value)

      isa(cur_I_P, SymEngine.Basic) && ( cur_I_P = subs(cur_I_P, symbols(:R_0) => calc_R_0(tmp_reactor)) )
      isa(cur_I_P, SymEngine.Basic) && ( cur_I_P = subs(cur_I_P, symbols(:B_0) => calc_R_0(tmp_reactor)) )
      isa(cur_I_P, SymEngine.Basic) && ( cur_I_P = subs(cur_I_P, symbols(:R_0) => calc_R_0(tmp_reactor)) )
    end

    isnan(cur_I_P) && continue

    cur_I_P = float(cur_I_P)

    isa(cur_I_P, Complex) && continue

    tmp_reactor.I_P = float(cur_I_P)

    push!(matched_reactors, update!(tmp_reactor))
  end

  matched_reactors
end
