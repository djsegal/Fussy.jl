function calc_R_0(cur_reactor::AbstractReactor)
  cur_constraint = cur_reactor.constraint

  cur_symbol = Symbol("R_0_from_$(cur_constraint)")

  cur_function = getfield(Fussy, cur_symbol)

  cur_R = cur_function(cur_reactor)

  cur_R
end
