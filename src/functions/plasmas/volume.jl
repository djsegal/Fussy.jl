"""
    volume(cur_R_0=R_0)

Lorem ipsum dolor sit amet.
"""
function volume(cur_R_0=R_0)
  cur_volume = geometry_scaling()

  cur_volume *= 2

  cur_volume *= pi ^ 2

  cur_volume *= cur_R_0

  cur_volume *= a(cur_R_0) ^ 2

  cur_volume *= kappa

  cur_volume
end
