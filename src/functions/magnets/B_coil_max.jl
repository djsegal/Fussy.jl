"""
    B_coil_max()

Lorem ipsum dolor sit amet.
"""
function B_coil_max()
  cur_B_coil_max = ( B_0 / 1u"T" )

  cur_B_coil_max /= 1 - magnet_normalized_radius()

  cur_B_coil_max
end
