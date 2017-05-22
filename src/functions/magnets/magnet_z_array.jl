"""
    magnet_z_array()

Lorem ipsum dolor sit amet.
"""
function magnet_z_array()

  k1, k2, k3 = magnet_k_array()

  # Cubic Solution
  polynz = Polynomials.Poly(reverse([1, k2/k3, k1/k3, (( R_0 / 1u"m" ))/((magnet_inner_radius())*k3) + 1/k3]))

  z = roots(polynz)

  z

end
