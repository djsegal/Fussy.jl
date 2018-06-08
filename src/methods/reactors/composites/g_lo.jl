@symbol_func function G_LO(cur_reactor::AbstractReactor)
  cur_inner_radius = R_CS(cur_reactor)

  cur_outer_radius = cur_inner_radius + d(cur_reactor)

  cur_G = cur_inner_radius * cur_outer_radius

  cur_G += cur_inner_radius ^ 2

  cur_G += cur_outer_radius ^ 2

  cur_G /= 3

  cur_G
end
