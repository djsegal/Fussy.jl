"""
    magnet_L2()

Curved Section Arc Length.
"""
function magnet_L2()

  k1, k2, k3 = magnet_k_array()
  c1, c2 = magnet_c_array()

  cur_blanket_thickness = blanket_thickness()

  func = (x) -> sqrt((( a() / 1u"m" ) + ( cur_blanket_thickness / 1u"m")).^2.*(2*k1*x + 4*k2*x.^3 + 6*k3*x.^5) .^2 +
      (kappa.*( a() / 1u"m" ) + ( cur_blanket_thickness / 1u"m")).^2.*(c1 - 3*c2*x.^2).^2)

  L2 = QuadGK.quadgk(func,0,1)[1]

  L2

end
