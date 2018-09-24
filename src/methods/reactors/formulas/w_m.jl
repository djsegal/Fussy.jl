@symbol_func function W_M(cur_reactor::AbstractReactor)
  cur_energy = K_WM(cur_reactor)

  cur_energy *= cur_reactor.R_0 ^ 3

  cur_energy *= cur_reactor.B_0 ^ 2

  cur_energy
end
