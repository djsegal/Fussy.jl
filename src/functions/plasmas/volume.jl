"""
    volume()

Lorem ipsum dolor sit amet.
"""
function volume()
  cur_volume = geometry_scaling()

  cur_volume *= 2

  cur_volume *= pi ^ 2

  cur_volume *= R_0

  cur_volume *= a() ^ 2

  cur_volume *= kappa

  cur_volume
end
