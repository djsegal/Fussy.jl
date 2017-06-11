@doc """
    magnet_z_array(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
@memoize function magnet_z_array(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  k1, k2, k3 = magnet_k_array()

  # Cubic Solution

  poly_array = [ k3 , k2 , k1 ]

  cur_last_value = ( cur_R_0 / 1u"m" )

  cur_last_value /= magnet_inner_radius()

  cur_last_value += 1

  if eltype(cur_last_value) == SymPy.Sym

    cur_last_value = magnet_subs(
      cur_last_value, cur_R_0, cur_n_bar, cur_I_M
    )

  end

  push!(poly_array, cur_last_value)

  poly_array /= k3

  reverse!(poly_array)

  polynz = Polynomials.Poly(poly_array)

  z = roots(polynz)

  z

end
