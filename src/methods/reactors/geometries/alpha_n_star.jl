@symbol_func function alpha_n_star(cur_reactor::AbstractReactor)
  cur_scaling = cur_reactor.mode_scaling

  cur_alpha_star = 1.0

  cur_alpha_star += cur_scaling[:n]

  cur_alpha_star -= 2 * cur_scaling[:P]

  cur_alpha_star
end
