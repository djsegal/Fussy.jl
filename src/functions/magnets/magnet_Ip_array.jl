@doc """
    magnet_Ip_array()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_Ip_array()

  Ip2 = -0.1750
  Ip5 = -0.1750
  Ip3 = -0.4250
  Ip4 = -0.4250

  cur_Ip_array = [ Ip2 Ip5 Ip3 Ip4 ]

  cur_Ip_array *= -1

  cur_Ip_array *= ( I_M / 1u"A" )

  cur_Ip_array

end
