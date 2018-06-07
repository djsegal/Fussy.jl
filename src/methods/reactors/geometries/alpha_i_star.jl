@symbol_func function alpha_I_star(cur_reactor::AbstractReactor)
  cur_scaling = cur_reactor.mode_scaling

  cur_alpha_star = cur_scaling[:I]

  cur_alpha_star += alpha_n_star(cur_reactor)

  cur_alpha_star
end
