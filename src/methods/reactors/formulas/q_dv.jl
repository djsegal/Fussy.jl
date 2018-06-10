@symbol_func function q_DV(cur_reactor::AbstractReactor)
  cur_q = 18.31e-3

  cur_q *= 1 + cur_reactor.Q / 5.0

  cur_q *= 2 ^ 0.6

  cur_q /= ( 1.0 + cur_reactor.kappa_95 ^ 2 ) ^ 0.6

  cur_q *= P_H(cur_reactor)

  cur_q *= cur_reactor.I_P ^ 1.2

  cur_q /= cur_reactor.epsilon ^ 1.2

  cur_q /= cur_reactor.R_0 ^ 2.2

  cur_q
end
