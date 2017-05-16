"""
    surface_area(cur_R_0=R_0)

Lorem ipsum dolor sit amet.
"""
function surface_area(cur_R_0=R_0)
  cur_surface_area = geometry_scaling()

  cur_surface_area *= pi

  cur_surface_area *= a(cur_R_0) ^ 2

  cur_surface_area *= kappa

  cur_surface_area
end
