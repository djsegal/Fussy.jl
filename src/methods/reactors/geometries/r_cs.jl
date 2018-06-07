@symbol_func function R_CS(cur_reactor::AbstractReactor)
  cur_R = cur_reactor.R_0

  cur_R -= a(cur_reactor)

  cur_R -= cur_reactor.b

  cur_R -= c(cur_reactor)

  cur_R -= K_DO(cur_reactor)

  cur_R /= ( 1 + K_DR(cur_reactor) )

  cur_R
end
