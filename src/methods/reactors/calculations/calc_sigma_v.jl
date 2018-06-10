@symbol_func function calc_sigma_v(cur_reactor::AbstractReactor)
  is_positive(cur_reactor.T_bar) || return NaN

  cur_nu_n = cur_reactor.nu_n

  cur_func = function (cur_rho)
    cur_temp = T_rho(cur_reactor, cur_rho)

    cur_value = 1.0 - cur_rho ^ 2

    cur_value ^= 2 * cur_nu_n

    cur_value *= cur_rho

    cur_value *= _bosch_hale(cur_temp)

    cur_value
  end

  cur_reactor.is_symbolic &&
    ( cur_func = cur_func(rho_sym) )

  cur_sigma_v = norm_int(cur_func)

  cur_sigma_v *= ( 1 + cur_nu_n ) ^ 2

  cur_sigma_v *= 1e21

  cur_sigma_v
end

@symbol_func function calc_sigma_v(cur_reactor::AbstractReactor, cur_formula::Union{Void, SymEngine.Basic})
  cur_sigma_v = calc_sigma_v(cur_reactor)

  cur_value = subs(
    cur_formula,
    symbols(:sigma_v) => cur_sigma_v
  )

  cur_value
end

_bosch_hale(::SymEngine.Basic) = symbols(:sigma_v_ave)

function _bosch_hale(cur_temp::AbstractFloat)
  cur_theta = _bosch_hale_theta(cur_temp)

  cur_xi = _bosch_hale_xi(cur_theta)

  cur_sigma_v_ave = bosch_hale_coeffs[1]

  cur_sigma_v_ave *= cur_theta

  cur_sigma_v_ave *= sqrt(cur_xi)

  cur_sigma_v_ave /= sqrt(reduced_mass)

  cur_sigma_v_ave /= sqrt(cur_temp) ^ 3

  cur_sigma_v_ave *= exp(-3 * cur_xi)

  cur_sigma_v_ave *= 1e-6

  cur_sigma_v_ave
end

function _bosch_hale_theta(cur_temp::AbstractFloat)
  cur_coeffs = bosch_hale_coeffs

  cur_numerator = cur_coeffs[4] + cur_temp * cur_coeffs[6]
  cur_numerator = cur_coeffs[2] + cur_temp * cur_numerator

  cur_numerator *= cur_temp

  cur_denominator = cur_coeffs[5] + cur_temp * cur_coeffs[7]
  cur_denominator = cur_coeffs[3] + cur_temp * cur_denominator

  cur_denominator *= cur_temp
  cur_denominator += 1

  cur_theta = cur_temp

  cur_theta /= (
    1 - cur_numerator / cur_denominator
  )

  cur_theta
end

function _bosch_hale_xi(cur_theta::AbstractFloat)
  cur_xi = gamov_const ^ 2

  cur_xi /= 4 * cur_theta

  cur_xi ^= (1/3)

  cur_xi
end
