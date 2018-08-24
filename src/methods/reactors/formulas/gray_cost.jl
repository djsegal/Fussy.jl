@symbol_func function gray_cost(cur_reactor::AbstractReactor)
  cur_cost = W_M(cur_reactor)

  cur_cost /= P_F(cur_reactor)

  cur_cost
end
