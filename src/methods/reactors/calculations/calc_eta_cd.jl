function calc_eta_CD(cur_reactor::AbstractReactor; strong_fail::Bool=false)
  cur_rho_m = _rho_m(cur_reactor)

  isnan(cur_rho_m) && return NaN

  cur_rho_j_list = _rho_j(cur_reactor, rho_sym)

  isempty(cur_rho_j_list) && return NaN

  for (cur_index, cur_rho_j) in enumerate(cur_rho_j_list)
    ( cur_rho_m < cur_rho_j ) && continue

    tmp_rho_j_list = _rho_j(cur_reactor, cur_rho_m)

    if isempty(tmp_rho_j_list)
      cur_rho_j_list[cur_index] = NaN
      continue
    end

    if strong_fail
      @assert length(tmp_rho_j_list) == 1
    else
      if length(tmp_rho_j_list) != 1
        custom_log("Too many rho_j in tmp list")
        custom_log(tmp_rho_j_list)
        custom_log(cur_reactor)
        return NaN
      end
    end

    cur_rho_j_list[cur_index] = first(tmp_rho_j_list)
  end

  filter!(!isnan, cur_rho_j_list)
  isempty(cur_rho_j_list) && return NaN

  cur_rho_j_list = unique(cur_rho_j_list)
  filter_approx!(cur_rho_j_list)

  if strong_fail
    @assert length(cur_rho_j_list) == 1
  else
    if length(cur_rho_j_list) != 1
      custom_log("Too many rho_j in cur list")
      custom_log(cur_rho_j_list)
      custom_log(cur_reactor)
      return NaN
    end
  end

  cur_rho_j = first(cur_rho_j_list)

  cur_eta_twiddle = _wave_eta_twiddle(cur_reactor, cur_rho_j)

  cur_eta_CD = 0.06108 * cur_reactor.eta_LH

  cur_eta_CD /= log( plasma_parameter(cur_reactor) )

  cur_eta_CD *= ( 1 + cur_reactor.nu_T )

  cur_eta_CD *= cur_reactor.T_bar

  cur_eta_CD *= ( 1 - cur_rho_j ^ 2 ) ^ cur_reactor.nu_T

  cur_eta_CD *= cur_eta_twiddle

  cur_eta_CD
end

@symbol_func function _rho_j(cur_reactor::AbstractReactor, nested_rho::AbstractSymbol)
  cur_rho = rho_sym

  cur_nu_T = cur_reactor.nu_T

  cur_equation = _n_para_2(cur_reactor, nested_rho)

  cur_equation *= ( 1 - cur_rho ^ 2 ) ^ cur_nu_T

  cur_equation *= ( 1 + cur_nu_T )

  cur_equation -= ( 28.39 / cur_reactor.T_bar )

  solved_rhos = []

  for cur_attempt in 1:4
    solved_rhos = find_roots(
      cur_equation, min_rho, max_rho,
      no_pts=no_pts_rho, abstol = 1e-4
    )

    isempty(solved_rhos) || break
  end

  filter_approx!(solved_rhos)

  solved_rhos
end

function _rho_m(cur_reactor::AbstractReactor)
  cur_rho = rho_sym

  cur_equation = _n_para_2(cur_reactor, cur_rho)

  is_nan(cur_equation) && return NaN

  cur_equation *= -1

  cur_func = function (tmp_rho)
    cur_value = float(cur_equation(tmp_rho))
    isa(cur_value, Complex) && return Inf
    cur_value
  end

  solved_rho = NaN

  try
    solved_rho = optimize(
      cur_func, min_rho, max_rho
    ).minimizer
  catch cur_error
    isa(cur_error, DomainError) || rethrow(cur_error)
  end

  solved_rho
end

@symbol_func function _n_para_2(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_X = _wave_X(cur_reactor, cur_rho)

  cur_omega_2 = _omega_hat_2(cur_reactor)

  cur_n = sqrt( 1.0 + cur_X - ( cur_X / cur_omega_2 ) )

  cur_n += sqrt( cur_X )

  cur_n ^= 2
end

@symbol_func function _omega_hat_2(cur_reactor::AbstractReactor)
  cur_X = _wave_X(cur_reactor, 0.0)

  cur_omega_2 = 4.0 * wave_gamma ^ 2

  cur_omega_2 *= cur_X * ( 1 + cur_X )

  cur_omega_2 += 1

  cur_omega_2 ^= 1/2

  cur_omega_2 += 1

  cur_omega_2 /= 2

  cur_omega_2 *= cur_X / ( 1 + cur_X )
end

@symbol_func function _wave_X(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_X = omega_pe(cur_reactor, cur_rho) ^ 2

  cur_X /= omega_ce(cur_reactor, cur_rho) ^ 2

  cur_X
end

@symbol_func function _wave_w(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_w = cur_reactor.speed_of_light

  cur_w /= v_te(cur_reactor, cur_rho)

  cur_w /= sqrt(_n_para_2(cur_reactor, cur_rho))

  cur_w
end

@symbol_func function _wave_B_M(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_B = B_rho(cur_reactor, cur_rho, 180.0)
end

@symbol_func function _wave_x_t_2(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_B = B_rho(cur_reactor, cur_rho, cur_reactor.wave_theta)

  cur_x_2 = _wave_w(cur_reactor, cur_rho) ^ 2

  cur_x_2 *= cur_B

  cur_x_2 /= _wave_B_M(cur_reactor, cur_rho) - cur_B

  cur_x_2
end

@symbol_func function _wave_K(cur_reactor::AbstractReactor)
  cur_K = 2.12

  cur_K /= cur_reactor.Z_eff

  cur_K
end

@symbol_func function _wave_D(cur_reactor::AbstractReactor)
  cur_D = 3.83

  cur_D /= cur_reactor.Z_eff ^ sqrt(1/2)

  cur_D
end

@symbol_func function _wave_eta_0(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_w = _wave_w(cur_reactor, cur_rho)

  cur_eta = ( _wave_K(cur_reactor) / cur_w )

  cur_eta += _wave_D(cur_reactor)

  cur_eta += ( 8 * cur_w ^ 2 ) / ( 5 + cur_reactor.Z_eff )

  cur_eta
end

@symbol_func function _wave_C(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_x_2 = _wave_x_t_2(cur_reactor, cur_rho)

  cur_C = 1.0

  cur_C -= exp( -1.0 * ( wave_c * cur_x_2 ) ^ wave_m )

  cur_C
end

@symbol_func function _wave_R(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_w = _wave_w(cur_reactor, cur_rho)

  cur_numerator = sqrt( wave_x_r ^ 2 + cur_w ^ 2 )

  cur_denominator = cur_w

  cur_denominator /= ( cur_reactor.epsilon * cur_rho ) ^ wave_n

  cur_denominator += wave_x_r

  cur_R = 1.0

  cur_R -= ( cur_numerator / cur_denominator )

  cur_R
end

@symbol_func function _wave_eta_twiddle(cur_reactor::AbstractReactor, cur_rho::AbstractSymbol)
  cur_eta = wave_M

  cur_eta *= _wave_C(cur_reactor, cur_rho)

  cur_eta *= _wave_R(cur_reactor, cur_rho)

  cur_eta *= _wave_eta_0(cur_reactor, cur_rho)

  cur_eta
end
