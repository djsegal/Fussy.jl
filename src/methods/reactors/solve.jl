function solve!(cur_reactor::AbstractReactor)
  isa(cur_reactor.T_bar, SymEngine.Basic) && return cur_reactor

  cur_reactor.is_good || return cur_reactor

  cur_I_P_list = solve(cur_reactor)
  cur_reactor.is_solved = true

  cur_reactor.I_P = isempty(cur_I_P_list) ? NaN : first(cur_I_P_list)
  cur_reactor.is_good = false

  valid_reactors = []
  valid_costs = []

  for cur_I_P in cur_I_P_list
    work_reactor = deepcopy(cur_reactor)

    work_reactor.I_P = cur_I_P
    work_reactor.is_good = true

    update!(work_reactor)
    work_reactor.is_valid || continue

    push!(valid_reactors, work_reactor)
    push!(valid_costs, work_reactor.cost)
  end

  if !isempty(valid_reactors)
    cur_reactor.I_P = valid_reactors[indmin(valid_costs)].I_P
    cur_reactor.is_good = true
  end

  update!(cur_reactor)

  cur_reactor
end

function solve(cur_reactor::AbstractReactor)
  cur_reactor.T_bar <= 0 && return []

  tmp_reactor = deepcopy(cur_reactor)

  tmp_reactor.sigma_v = calc_sigma_v(tmp_reactor)
  isnan(tmp_reactor.sigma_v) && return []

  cur_equation = calc_I_P(tmp_reactor)

  isa(cur_equation, SymEngine.Basic) || return [cur_equation]

  cur_B_0 = calc_B_0(tmp_reactor)

  is_nan(cur_B_0) && return []

  cur_equation = subs(
    cur_equation,
    symbols(:R_0) => calc_R_0(tmp_reactor),
    symbols(:B_0) => cur_B_0
  )

  cur_equation /= symbols(:I_P)

  cur_equation -= 1.0

  _solve(tmp_reactor, cur_equation)
end

function _solve(cur_reactor::AbstractReactor, cur_equation::SymEngine.Basic)
  cur_atol = 10 * eps()

  cur_I_P_list = find_roots(
    cur_equation, min_I_P, max_I_P,
    no_pts = no_pts_I_P, reltol = 1e-2
  )

  isempty(cur_I_P_list) && return []

  good_reactors = Vector{AbstractReactor}()

  for (cur_index, cur_I_P) in enumerate(cur_I_P_list)
    isapprox(0.0, cur_I_P, atol=cur_atol) && continue

    tmp_reactor = deepcopy(cur_reactor)

    tmp_reactor.I_P = cur_I_P

    try

      tmp_reactor.B_0 = convert(Real, calc_B_0(tmp_reactor))
      tmp_reactor.R_0 = convert(Real, calc_R_0(tmp_reactor))
      tmp_reactor.n_bar = convert(Real, calc_n_bar(tmp_reactor))

    catch cur_error

      is_caught_error = isa(cur_error, InexactError)
      is_caught_error |= isa(cur_error, DomainError)
      is_caught_error || rethrow(cur_error)

      continue

    end

    ( 0 <= f_BS(tmp_reactor) <= 1 ) || continue
    ( 0 <= f_CD(tmp_reactor) <= 1 ) || continue

    ( f_IN(tmp_reactor) > -0.01 ) || continue
    ( f_IN(tmp_reactor) <= 1.00 ) || continue

    f_total = f_BS(tmp_reactor) + f_CD(tmp_reactor) + f_IN(tmp_reactor)

    isapprox(1.0, f_total, atol=cur_atol) || continue

    push!(good_reactors, tmp_reactor)
  end

  isempty(good_reactors) && return []

  real_root_count = length(cur_I_P_list)

  @assert real_root_count <= max_roots

  cur_I_P_list = map(tmp_reactor -> tmp_reactor.I_P, good_reactors)

  cur_I_P_list
end
