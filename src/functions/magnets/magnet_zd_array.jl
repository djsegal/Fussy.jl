"""
    magnet_zd_array()

Lorem ipsum dolor sit amet.
"""
function magnet_zd_array()
  z1 = 1.464*( a() / 1u"m" )*kappa
  z2 = ( a() / 1u"m" )*kappa
  z3 = 1.272*( a() / 1u"m" )*kappa
  z4 = -1.464*( a() / 1u"m" )*kappa
  z5 = -( a() / 1u"m" )*kappa
  z6 = -1.272*( a() / 1u"m" )*kappa

  zd = [z1 z6 z2 z5 z3 z4]

  zd
end
