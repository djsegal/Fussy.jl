function b_p(cur_gamma::SymEngine.Basic, cur_rho::SymEngine.Basic, use_default::Bool=false)
  use_default && return b_p_default(cur_gamma, cur_rho)
  symbols(:b_theta)
end

function b_p(cur_gamma::AbstractFloat, cur_rho::AbstractFloat)
  b_p_default(cur_gamma, cur_rho)
end

function b_p_default(cur_gamma::AbstractSymbol, cur_rho::AbstractSymbol)
  cur_repeat = 1 + cur_gamma

  cur_b_p = cur_gamma * cur_rho ^ 2
  cur_b_p -= cur_repeat

  cur_b_p *= -exp( cur_gamma * cur_rho ^ 2 )
  cur_b_p -= cur_repeat

  cur_b_p /= cur_rho
  cur_b_p /= exp(cur_gamma) - cur_repeat

  cur_b_p
end

function int_b_p(cur_gamma::AbstractFloat)
  quadgk(
    cur_rho -> cur_rho * b_p(cur_gamma, cur_rho)^2,
    integral_zero,
    integral_one
  )[1]
end
