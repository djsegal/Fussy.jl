@memoize function magnet_zp_array_mem()

  zp = [
    +1.35,
    -1.35,
    +0.83,
    -0.83
  ]

  zp = zp'

  zp *= ( a_kappa() / 1u"m" )

  zp

end

"""
    magnet_zp_array()

Lorem ipsum dolor sit amet.
"""
magnet_zp_array() = copy(magnet_zp_array_mem())
