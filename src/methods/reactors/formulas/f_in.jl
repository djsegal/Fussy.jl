@symbol_func function f_IN(cur_reactor::AbstractReactor)
  cur_f = 1.0

  cur_f -= f_BS(cur_reactor)

  cur_f -= f_CD(cur_reactor)

  cur_f
end

