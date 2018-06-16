@symbol_func function B_V(cur_reactor::AbstractReactor)
  cur_B = 0.1

  cur_B *= cur_reactor.I_P

  cur_B /= cur_reactor.R_0

  cur_B *= ( K_VI(cur_reactor) + beta_P(cur_reactor) )

  cur_B
end
