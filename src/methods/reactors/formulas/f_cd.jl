@symbol_func function f_CD(cur_reactor::AbstractReactor)
  cur_f = K_CD(cur_reactor)

  cur_f *= cur_reactor.sigma_v

  cur_f
end

