"""
    magnet_Ip_array()

Lorem ipsum dolor sit amet.
"""
function magnet_Ip_array()
  Ip2 = -0.1750*( I_M / 1u"A" )
  Ip5 = -0.1750*( I_M / 1u"A" )
  Ip3 = -0.4250*( I_M / 1u"A" )
  Ip4 = -0.4250*( I_M / 1u"A" )

  Ip = -[Ip2 Ip5 Ip3 Ip4]

  Ip
end
