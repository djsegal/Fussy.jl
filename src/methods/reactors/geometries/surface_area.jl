@symbol_func function surface_area(cur_reactor::AbstractReactor)
  cur_left_part = 4.0

  cur_left_part *= cur_reactor.pi ^ 2

  cur_left_part *= a(cur_reactor)

  cur_left_part *= cur_reactor.R_0

  cur_right_part = ( cur_reactor.kappa_95 ^ 2 - 1 )

  cur_right_part *= ( 2 / cur_reactor.pi )

  cur_right_part += 1

  cur_right_part /= cur_reactor.kappa_95

  cur_area = cur_left_part

  cur_area *= cur_right_part

  cur_area
end
