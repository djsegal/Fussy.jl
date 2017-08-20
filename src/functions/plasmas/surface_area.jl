"""
    surface_area(cur_R_0=R_0)

Lorem ipsum dolor sit amet.
"""
function surface_area(cur_R_0=R_0)
  cur_surface_area = ( kappa ^ 2 - 1.0 )

  cur_surface_area *= ( 2 / pi )

  cur_surface_area += 1.0

  cur_surface_area *= 4 * pi ^ 2

  cur_surface_area *= cur_R_0

  cur_surface_area *= a(cur_R_0)

  cur_surface_area /= kappa

  cur_surface_area
end
