"""
    magnet_zd_array()

Lorem ipsum dolor sit amet.
"""
function magnet_zd_array()

  zd = [
    +1.464,
    -1.272,
    +1.000,
    -1.000,
    +1.272,
    -1.464
  ]

  zd = zd'

  zd *= ( a_kappa() / 1u"m" )

  zd

end
