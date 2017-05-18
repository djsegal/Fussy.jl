"""
    magnet_Id_array()

Lorem ipsum dolor sit amet.
"""
function magnet_Id_array()
  I1 = 0.485*( I_M / 1u"A" )
  I2 = -0.558*( I_M / 1u"A" )
  I3 = 0.669*( I_M / 1u"A" )
  I4 = 0.485*( I_M / 1u"A" )
  I5 = -0.558*( I_M / 1u"A" )
  I6 = 0.669*( I_M / 1u"A" )

  Id = -[I1 I6 I2 I5 I3 I4]
end
