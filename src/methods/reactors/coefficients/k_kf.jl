@symbol_func function K_KF(cur_reactor::AbstractReactor)
  cur_K = cur_reactor.max_q_95

  cur_K /= 5

  cur_K /= cur_reactor.epsilon ^ 2

  cur_K /= _f_q(cur_reactor)

  cur_K
end

@symbol_func function _f_q(cur_reactor::AbstractReactor)
  cur_epsilon = cur_reactor.epsilon

  cur_kappa = cur_reactor.kappa_95

  cur_delta = cur_reactor.delta_95

  cur_left_term = 1.17 - 0.65 * cur_epsilon

  cur_left_term /= 2 * ( 1 - cur_epsilon ^ 2 ) ^ 2

  cur_right_term = 1 + 2 * cur_delta ^ 2 - 1.2 * cur_delta ^ 3

  cur_right_term = 1 + cur_kappa ^ 2 * cur_right_term

  cur_f_q = cur_left_term

  cur_f_q *= cur_right_term

  cur_f_q
end
