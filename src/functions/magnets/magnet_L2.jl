@doc """
    magnet_L2(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Curved Section Arc Length.
"""
@memoize function magnet_L2(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  k1, k2, k3 = magnet_k_array()
  c1, c2 = magnet_c_array()

  cur_blanket_thickness = blanket_thickness(cur_R_0, cur_n_bar, cur_I_M)
  cur_blanket_thickness /= 1u"m"

  cur_a = magnet_subs(
    ( a(cur_R_0) / 1u"m" ),
    cur_R_0, cur_n_bar, cur_I_M
  )

  cur_func = function (x)
    cur_left_part = ( cur_a + cur_blanket_thickness ) ^ 2
    cur_left_part *= ( 2*k1*x + 4*k2*x^3 + 6*k3*x^5 ) ^ 2

    cur_right_part = ( kappa * cur_a + cur_blanket_thickness ) ^ 2
    cur_right_part *= ( c1 - 3*c2*x^2 ) ^ 2

    cur_value = cur_left_part + cur_right_part

    cur_value ^= 0.5

    cur_value
  end

  L2 = QuadGK.quadgk(cur_func, 0, 1)[1]

  L2

end
