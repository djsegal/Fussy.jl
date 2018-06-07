@symbol_func function K_P(cur_reactor::AbstractReactor)
  cur_K = 5.0 + cur_reactor.Q

  cur_K /= 5.0 * cur_reactor.Q

  cur_K
end
