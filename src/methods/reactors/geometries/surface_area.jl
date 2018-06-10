@symbol_func function surface_area(cur_reactor::AbstractReactor)
  cur_area = 4.0

  cur_area *= cur_reactor.pi ^ 2

  cur_area *= a(cur_reactor)

  cur_area *= cur_reactor.R_0

  cur_area *= sqrt( 1 + cur_reactor.kappa_95 ^ 2 )

  cur_area /= sqrt(2)

  cur_area
end
