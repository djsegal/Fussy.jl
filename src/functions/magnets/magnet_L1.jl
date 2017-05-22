"""
    magnet_L1()

Straight Section Arc Length.
"""
function magnet_L1()

  L1 = a_kappa()

  L1 += blanket_thickness()

  L1 /= 1u"m"

  L1 *= magnet_straight_factor

  L1

end
