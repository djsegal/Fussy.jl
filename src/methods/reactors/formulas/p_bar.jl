@symbol_func function p_bar(cur_reactor::AbstractReactor)
  cur_p = 0.1581

  cur_p *= 1 + cur_reactor.f_D

  cur_p *= 1 + cur_reactor.nu_n

  cur_p *= 1 + cur_reactor.nu_T

  cur_p /= 1 + cur_reactor.nu_n + cur_reactor.nu_T

  cur_p *= cur_reactor.n_bar

  cur_p *= cur_reactor.T_bar

  cur_p
end
