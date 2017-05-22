"""
    magnet_Id_array()

Lorem ipsum dolor sit amet.
"""
function magnet_Id_array()

  I1 = +0.485
  I2 = -0.558
  I3 = +0.669
  I4 = +0.485
  I5 = -0.558
  I6 = +0.669

  cur_Id_array = [ I1 I6 I2 I5 I3 I4 ]

  cur_Id_array *= -1

  cur_Id_array *= ( I_M / 1u"A" )

  cur_Id_array

end
