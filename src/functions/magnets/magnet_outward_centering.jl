"""
    magnet_outward_centering()

Lorem ipsum dolor sit amet.
"""
function magnet_outward_centering()

  k1, k2, k3 = magnet_k_array()
  c1, c2 = magnet_c_array()
  z1, z2, z3 = magnet_z_array()

  # Outward Centering
  FR2 = -( B_0 / 1u"T" )^2
  FR2 *= ( R_0 / 1u"m" )^2
  FR2 /= (2*standard_mu_0)
  FR2 *= (c1/k3)
  FR2 *= ( kappa * a() + blanket_thickness() ) / 1u"m"
  FR2 /= magnet_inner_radius()

  FR2 *= (
      (1-3*c2/c1*z1)*acoth(sqrt(z1))/((z1-z2)*(z1-z3)*sqrt(z1)) +
      (3*c2/c1*z2-1)*acoth(sqrt(z2))/((z1-z2)*(z2-z3)*sqrt(z2)) +
      (3*c2/c1*z3-1)*acoth(sqrt(z3))/((z1-z3)*(z3-z2)*sqrt(z3))
  )

  FR2

end
