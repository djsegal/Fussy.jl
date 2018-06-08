@symbol_func function K_VI(cur_reactor::AbstractReactor)
  cur_K = cur_reactor.l_i / 2.0

  cur_K -= 3/2

  cur_K += log( 8.0 / cur_reactor.epsilon )

  cur_K
end
