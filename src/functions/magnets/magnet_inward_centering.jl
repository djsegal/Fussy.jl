@doc """
    magnet_inward_centering()

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_inward_centering()

  FR1 = -( B_0 / 1u"T" )^2
  FR1 *= ( R_0 / 1u"m" )^2

  FR1 /= 2 * standard_mu_0
  FR1 *= magnet_straight_factor
  FR1 *= a_kappa() + blanket_thickness()

  FR1 /= 1u"m"

  FR1 /= ( R_0 / 1u"m" ) - magnet_inner_radius()

  FR1

end