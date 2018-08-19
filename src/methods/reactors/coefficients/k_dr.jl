@symbol_func function K_DR(cur_reactor::AbstractReactor)
  cur_reactor.is_pulsed || return 0.0

  cur_denominator = cur_reactor.sigma_CS

  cur_denominator *= (12/5) * cur_reactor.pi

  cur_denominator -= cur_reactor.B_CS ^ 2

  cur_numerator = 3.0

  cur_numerator *= cur_reactor.B_CS ^ 2

  cur_K = cur_numerator

  cur_K /= cur_denominator

  cur_K
end
