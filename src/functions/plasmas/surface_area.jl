"""
    surface_area(cur_R_0=R_0)

Lorem ipsum dolor sit amet.
"""
function surface_area(cur_R_0=R_0)

  cur_c_part = 1.0

  cur_c_part -= 2 * delta
  cur_c_part -= x_aa_of_pi()

  cur_c_part /= 8.0

  cur_c_array = [
    0 - delta / 2.0
    1 + cur_c_part
    0 + delta / 2.0
    0 - cur_c_part
  ]

  cur_func = function (cur_t)
    dydt = kappa * cos(cur_t)

    dxdt = 0.0

    for cur_index in 0:3
      cur_dxdt_part = cur_index
      cur_dxdt_part *= cur_c_array[cur_index+1]
      cur_dxdt_part *= sin(cur_index * cur_t)

      dxdt -= cur_dxdt_part
    end

    cur_value = sqrt( dxdt^2 + dydt^2 )

    cur_value
  end

  cur_surface_area = QuadGK.quadgk( cur_func , 0 , (2*pi) )[1]

  cur_surface_area *= 1u"m"

  cur_surface_area *= 2 * pi * cur_R_0

  cur_surface_area
end
