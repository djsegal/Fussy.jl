"""
    magnet_z_array()

Lorem ipsum dolor sit amet.
"""
function magnet_z_array()

  k1, k2, k3 = magnet_k_array()

  # Cubic Solution

  poly_array = [ k3 , k2 , k1 ]

  cur_last_value = ( R_0 / 1u"m" )

  cur_last_value /= magnet_inner_radius()

  cur_last_value += 1

  push!(poly_array, cur_last_value)

  poly_array /= k3

  reverse!(poly_array)

  polynz = Polynomials.Poly(poly_array)

  z = roots(polynz)

  z

end
