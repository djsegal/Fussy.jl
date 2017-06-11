@doc """
    magnet_zd_array()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_zd_array()

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
