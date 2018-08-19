@symbol_func function G_CR(cur_reactor::AbstractReactor)
  cur_epsilon = epsilon_b(cur_reactor)

  cur_left_part = safe_symbol(cur_reactor, :B_0) ^ 2

  cur_left_part /= (8/5) * cur_reactor.pi

  cur_left_part /= cur_reactor.sigma_TF

  cur_left_part /= ( 1 - cur_epsilon )

  cur_right_part = 4 * cur_epsilon

  cur_right_part /= 1 + cur_epsilon

  cur_right_part += log(
    ( 1 + cur_epsilon ) / ( 1 - cur_epsilon )
  )

  cur_G = cur_left_part

  cur_G *= cur_right_part

  cur_G
end
