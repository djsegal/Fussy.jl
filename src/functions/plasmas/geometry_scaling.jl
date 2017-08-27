"""
    geometry_scaling(cur_delta=delta; cur_enable_geom_scaling=enable_geom_scaling)

Lorem ipsum dolor sit amet.
"""
function geometry_scaling(cur_delta=delta; cur_enable_geom_scaling=enable_geom_scaling)
  if !cur_enable_geom_scaling
    return 1.0
  end

  cur_geometry_scaling = 9

  cur_geometry_scaling -= 2 * cur_delta

  cur_geometry_scaling -= x_aa_of_pi(cur_delta)

  cur_geometry_scaling /= 8

  cur_geometry_scaling
end
