function solve!(cur_reactor::AbstractReactor, is_direct_call::Bool=true)

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

  is_direct_call || return cur_reactor

  update!(cur_reactor)

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
