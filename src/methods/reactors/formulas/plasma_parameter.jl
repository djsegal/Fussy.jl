@symbol_func function plasma_parameter(cur_reactor::AbstractReactor)
  cur_lambda = 5.4e6

  cur_lambda *= sqrt( cur_reactor.T_bar ^ 3 )

  cur_lambda /= sqrt( cur_reactor.n_bar )

  cur_lambda
end
