"""
    magnet_rp_array()

Lorem ipsum dolor sit amet.
"""
function magnet_rp_array()
  rp2 = ( R_0 / 1u"m" ) + ( a() / 1u"m" )*(1.56*kappa - delta)
  rp5 = ( R_0 / 1u"m" ) + ( a() / 1u"m" )*(1.56*kappa - delta)
  rp3 = ( R_0 / 1u"m" ) + ( a() / 1u"m" )*(1.84*kappa - delta)
  rp4 = ( R_0 / 1u"m" ) + ( a() / 1u"m" )*(1.84*kappa - delta)

  rp = [rp2 rp5 rp3 rp4]

  rp
end
