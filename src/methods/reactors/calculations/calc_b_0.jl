function calc_B_0(cur_reactor::AbstractReactor)
  cur_constraint = cur_reactor.constraint

  cur_symbol = Symbol("B_0_from_$(cur_constraint)")

  cur_function = getfield(Fussy, cur_symbol)

  cur_B = cur_function(cur_reactor)

  cur_B
end
