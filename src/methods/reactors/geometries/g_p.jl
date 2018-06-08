@symbol_func function g_p(cur_reactor::AbstractReactor)
  cur_kappa = cur_reactor.kappa_95

  cur_delta = cur_reactor.delta_95

  cur_factor = 1.0

  cur_factor += 2 * cur_delta ^ 2

  cur_factor -= 1.2 * cur_delta ^ 3

  cur_factor *= cur_kappa ^ 2

  cur_factor += 1

  cur_factor /= 2

  cur_factor
end
