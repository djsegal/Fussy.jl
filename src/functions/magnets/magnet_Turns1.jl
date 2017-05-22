"""
    magnet_Turns1()

Number of cable turns per coil.
"""
function magnet_Turns1()

  Turns1 = magnet_Ic()

  Turns1 /= magnet_Imax()

  Turns1 /= 1000

  Turns1 = ceil(Turns1)

  Turns1

end
