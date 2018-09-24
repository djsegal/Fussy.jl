function match(cur_reactor::AbstractReactor, cur_constraint::Symbol, cur_value::Union{Void, Number}=nothing, is_singular::Bool=true)
  cur_func = function (cur_T_bar::Number)
    tmp_reactor = deepcopy(cur_reactor)

    tmp_reactor.T_bar = real(cur_T_bar)

    tmp_reactor.T_bar <= 0 && return NaN

    tmp_reactor.sigma_v = calc_sigma_v(tmp_reactor)

    isnan(tmp_reactor.sigma_v) && return NaN

    cur_error = calc_I_P(tmp_reactor)

    cur_error /= symbols(:I_P)

    cur_error -= 1.0

    secondary_constraint = getfield(Fussy, Symbol("$(tmp_reactor.constraint)_equation"))(tmp_reactor)

    if cur_value == nothing
      tertiary_constraint = getfield(Fussy, Symbol("$(cur_constraint)_equation"))(tmp_reactor)
    else
      tertiary_constraint = getfield(Fussy, Symbol("$(cur_constraint)_equation"))(tmp_reactor, cur_value)
    end

    tmp_dict = equation_set_dict(
      EquationSet(tmp_reactor, secondary_constraint, tertiary_constraint)
    )

    any(is_nan, values(tmp_dict)) && return NaN

    @assert all(is_finite, values(tmp_dict))

    cur_error = subs(cur_error, tmp_dict...)

    cur_error = real(float(cur_error))

    cur_error
  end

  matched_reactors = _match(cur_reactor, cur_func, cur_constraint, cur_value)
  matched_reactors = filter!(work_reactor -> work_reactor.is_good, matched_reactors)

  isempty(matched_reactors) && return ( is_singular ? nothing : [] )

  if length(matched_reactors) > 1
    work_reactors = filter(work_reactor -> work_reactor.is_valid, matched_reactors)

    if !isempty(work_reactors)
      is_singular || return work_reactors

      if length(work_reactors) > 1
        custom_log("Bad match! Too many reactors!")
        custom_log(cur_constraint, " - ", cur_value)
        custom_log(work_reactors)
      end

      min_index = indmin(
        map(work_reactor -> (cur_constraint == :cost ? work_reactor.W_M : work_reactor.cost), work_reactors)
      )

      return work_reactors[min_index]
    end
  end

  is_singular && return first(matched_reactors)

  matched_reactors
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

    secondary_constraint = getfield(Fussy, Symbol("$(tmp_reactor.constraint)_equation"))(tmp_reactor)

    if cur_value == nothing
      tertiary_constraint = getfield(Fussy, Symbol("$(cur_constraint)_equation"))(tmp_reactor)
    else
      tertiary_constraint = getfield(Fussy, Symbol("$(cur_constraint)_equation"))(tmp_reactor, cur_value)
    end

    cur_I_P = EquationSet(tmp_reactor, secondary_constraint, tertiary_constraint).I_P

    isnan(cur_I_P) && continue

    cur_I_P = float(cur_I_P)

    isa(cur_I_P, Complex) && continue

    tmp_reactor.I_P = float(cur_I_P)

    push!(matched_reactors, update!(tmp_reactor))
  end

  matched_reactors
end
