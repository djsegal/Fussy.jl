@doc """
    magnet_normalized_radius()

Normalized Inner Thickness.
"""
@memoize function magnet_normalized_radius()

  cur_normalized_thickness = magnet_inner_radius()

  cur_normalized_thickness /= ( R_0 / 1u"m" )

  cur_normalized_thickness

end
