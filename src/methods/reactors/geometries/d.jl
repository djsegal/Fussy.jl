@symbol_func function d(cur_reactor::AbstractReactor)
  cur_d = K_DR(cur_reactor)

  cur_d *= R_CS(cur_reactor)

  cur_d += K_DO(cur_reactor)

  cur_d
end
