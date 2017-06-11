@doc """
    magnet_zp_array()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_zp_array()

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
