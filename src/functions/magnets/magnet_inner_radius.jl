"""
    magnet_inner_radius()

Lorem ipsum dolor sit amet.
"""
function magnet_inner_radius()
  cur_inner_radius = ( a() / 1u"m" )

  cur_inner_radius += ( blanket_thickness() / 1u"m" )

  cur_inner_radius
end
