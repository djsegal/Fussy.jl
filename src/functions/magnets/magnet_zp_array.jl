"""
    magnet_zp_array()

Lorem ipsum dolor sit amet.
"""
function magnet_zp_array()
  zp2 = 1.35*( a() / 1u"m" )*kappa
  zp5 = -1.35*( a() / 1u"m" )*kappa
  zp3 = 0.83*( a() / 1u"m" )*kappa
  zp4 = -0.83*( a() / 1u"m" )*kappa

  zp = [zp2 zp5 zp3 zp4]

  zp
end
