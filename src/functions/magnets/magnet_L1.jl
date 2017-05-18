"""
    magnet_L1()

Lorem ipsum dolor sit amet.
"""
function magnet_L1()
  L1 = magnet_straight_factor*(( a() / 1u"m" )*kappa + ( magnet_b() / 1u"m" )) # Straight Section Arc Length

  L1
end
