@symbol_func function G_PU(cur_reactor::AbstractReactor)
  cur_left_part = K_RP(cur_reactor)

  cur_left_part *= cur_reactor.tau_FT

  cur_right_part = K_LP(cur_reactor)

  cur_right_part *= safe_symbol(cur_reactor, :R_0) ^ 2

  cur_right_part *= cur_reactor.T_bar ^ (3/2)

  cur_G = cur_left_part

  cur_G += cur_right_part

  cur_G
end
