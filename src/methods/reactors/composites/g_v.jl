@symbol_func function G_V(cur_reactor::AbstractReactor)
  cur_G = safe_symbol(cur_reactor, :R_0) ^ 2

  cur_G -= ( R_CS(cur_reactor) + d(cur_reactor) ) ^ 2

  cur_G *= cur_reactor.T_bar ^ (3/2)

  cur_G *= cur_reactor.pi

  cur_G /= 1e7

  cur_G
end
