@symbol_func function P_T(cur_reactor::AbstractReactor)
  cur_P = P_F(cur_reactor)

  cur_P *= ( 1 + E_Li / E_F )

  cur_P
end
