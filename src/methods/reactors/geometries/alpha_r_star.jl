@symbol_func function alpha_R_star(cur_reactor::AbstractReactor)
  cur_scaling = cur_reactor.mode_scaling

  cur_alpha_star = cur_scaling[:R]

  cur_alpha_star += cur_scaling[:a]

  cur_alpha_star += cur_scaling[:P]

  cur_alpha_star -= 2 * ( 1 + cur_scaling[:n] )

  cur_alpha_star
end
