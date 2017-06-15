@memoize function magnet_zd_array_mem()

  zd = [
    +1.464,
    -1.464,
    +1.000,
    -1.000,
    +1.272,
    -1.272
  ]

  zd = zd'

  zd *= ( a_kappa() / 1u"m" )

  zd

end

"""
    magnet_zd_array()

Lorem ipsum dolor sit amet.
"""
magnet_zd_array() = copy(magnet_zd_array_mem())
