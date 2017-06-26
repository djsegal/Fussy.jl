@doc """
    magnet_outward_centering(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_outward_centering(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  k1, k2, k3 = magnet_k_array()
  c1, c2 = magnet_c_array()
  z1, z2, z3 = magnet_z_array(cur_R_0, cur_n_bar, cur_I_M)

  # Outward Centering

  FR2 = ( B_0 / 1u"T" )
  FR2 *= ( cur_R_0 / 1u"m" )
  FR2 ^= 2

  FR2 *= -1
  FR2 /= 2 * standard_mu_0
  FR2 *= c1 / k3

  FR2 *= (
    a_kappa(cur_R_0) +
    blanket_thickness(cur_R_0, cur_n_bar, cur_I_M)
  )

  FR2 /= 1u"m"
  FR2 /= magnet_inner_radius()

  FR2 *= (
      (1-3*c2/c1*z1)*acoth(sqrt(z1))/((z1-z2)*(z1-z3)*sqrt(z1)) +
      (3*c2/c1*z2-1)*acoth(sqrt(z2))/((z1-z2)*(z2-z3)*sqrt(z2)) +
      (3*c2/c1*z3-1)*acoth(sqrt(z3))/((z1-z3)*(z3-z2)*sqrt(z3))
  )

  FR2

end