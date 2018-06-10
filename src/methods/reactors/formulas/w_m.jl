@symbol_func function W_M(cur_reactor::AbstractReactor)
  cur_energy = cur_reactor.B_0 ^ 2

  cur_energy *= volume(cur_reactor)

  cur_energy /= 2

  cur_energy /= 4 * cur_reactor.pi * 1e-7

  cur_energy *= 1e-9

  cur_energy
end
