function B_P(cur_reactor::AbstractReactor)
  cur_B = (2/5) * cur_reactor.pi

  cur_B *= cur_reactor.I_P

  cur_B /= perimeter(cur_reactor)

  cur_B
end

function b_p(cur_gamma::SymEngine.Basic, cur_rho::SymEngine.Basic, use_default::Bool=false)
  use_default && return b_p_default(cur_gamma, cur_rho)
  symbols(:b_theta)
end

function b_p(cur_gamma::AbstractFloat, cur_rho::AbstractFloat)
  b_p_default(cur_gamma, cur_rho)
end

function b_p_default(cur_gamma::AbstractSymbol, cur_rho::AbstractSymbol)
  cur_repeat = 1 + cur_gamma

  cur_b = cur_gamma * cur_rho ^ 2
  cur_b -= cur_repeat

  cur_b *= -exp( cur_gamma * cur_rho ^ 2 )
  cur_b -= cur_repeat

  cur_b /= cur_rho
  cur_b /= exp(cur_gamma) - cur_repeat

  cur_b
end

function int_b_p(cur_gamma::AbstractFloat)
  isfinite(cur_gamma) || return NaN

  cur_func = (cur_rho) -> cur_rho * b_p(cur_gamma, cur_rho) ^ 2

  cur_integral = norm_int(cur_func)

  cur_integral
end
