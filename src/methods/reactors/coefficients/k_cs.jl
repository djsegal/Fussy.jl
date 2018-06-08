@symbol_func function K_CS(cur_reactor::AbstractReactor)
  cur_K = cur_reactor.k

  cur_K *= cur_reactor.B_CS

  cur_K *= sqrt( K_LP(cur_reactor) )

  cur_K /= sqrt(1e5)

  cur_K
end
