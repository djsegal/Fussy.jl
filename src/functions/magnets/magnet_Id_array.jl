@memoize function magnet_Id_array_mem()

  I1 = +0.485
  I2 = -0.558
  I3 = +0.669
  I4 = +0.485
  I5 = -0.558
  I6 = +0.669

  cur_Id_array = [ I1 I4 I2 I5 I3 I6 ]

  cur_Id_array *= -1

  cur_Id_array *= ( I_M / 1u"A" )

  cur_Id_array

end

"""
    magnet_Id_array()

Lorem ipsum dolor sit amet.
"""
magnet_Id_array() = copy(magnet_Id_array_mem())
