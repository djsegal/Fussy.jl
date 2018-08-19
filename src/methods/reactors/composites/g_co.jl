@symbol_func function G_CO(cur_reactor::AbstractReactor)
  cur_G = safe_symbol(cur_reactor, :B_0)

  cur_G /= (2/5) * cur_reactor.pi

  cur_G /= cur_reactor.J_TF

  cur_G /= ( 1 - epsilon_b(cur_reactor) )

  cur_G
end
