@symbol_func function K_WM(cur_reactor::AbstractReactor)
  cur_K = volume(cur_reactor)

  cur_K /= 2

  cur_K /= 4 * cur_reactor.pi * 1e-7

  cur_K /= safe_symbol(cur_reactor, :R_0) ^ 3

  cur_K *= 1e-9

  cur_K
end
