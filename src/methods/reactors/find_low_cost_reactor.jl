function find_low_cost_reactor(cur_reactor::AbstractReactor, soft_fail::Bool=false)
  cur_I_P_list = solve(cur_reactor)

  min_cost_reactor = nothing
  min_cost = Inf

  for cur_I_P in cur_I_P_list
    tmp_reactor = deepcopy(cur_reactor)
    tmp_reactor.I_P = cur_I_P
    update!(tmp_reactor)

    tmp_reactor.is_good || continue
    tmp_reactor.is_valid || continue
    ( tmp_reactor.cost < min_cost ) || continue

    min_cost_reactor = tmp_reactor
    min_cost = tmp_reactor.cost
  end

  if soft_fail && min_cost_reactor == nothing
    for cur_I_P in cur_I_P_list
      tmp_reactor = deepcopy(cur_reactor)
      tmp_reactor.I_P = cur_I_P
      update!(tmp_reactor)

      ( tmp_reactor.cost < min_cost ) || continue

      min_cost_reactor = tmp_reactor
      min_cost = tmp_reactor.cost
    end
  end

  min_cost_reactor
end
