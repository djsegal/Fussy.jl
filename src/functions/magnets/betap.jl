@doc """
    betap()

Lorem ipsum dolor sit amet.
"""
@memoize function betap()

  # Bta Calculation

  Bta = standard_mu_0

  Bta *= ( I_M / 1u"A" )

  Bta /= 2 * pi

  Bta /= ( a() / 1u"m" )

  # Pressure Calculation

  cur_shape_array = d_shape_array()

  press = shape_sigma

  press *= ( nu_n + nu_T )

  press += cur_shape_array[3]

  press *= cur_shape_array[2]

  press *= ( 3 + nu_n + nu_T )

  press += 6 * cur_shape_array[1] * cur_shape_array[2]

  press += 3 * cur_shape_array[3] * cur_shape_array[4]

  press *= ( a() / 1u"m" )

  press /= ( R_0 / 1u"m" )

  press /= ( 2 + nu_n + nu_T )

  press /= ( 3 + nu_n + nu_T )

  press += cur_shape_array[2]

  press *= 2

  press *= ( n_bar / 1u"m^-3" )

  press *= ( T_k / 1u"eV" )

  press *= 11600

  press *= ( Unitful.k / 1u"J/K" )

  press *= ( 1 + nu_n )

  press *= ( 1 + nu_T )

  press /= ( 1 + nu_n + nu_T )

  press = press |> NoUnits

  # betap Calculation

  cur_betap = 2

  cur_betap *= standard_mu_0

  cur_betap *= press

  cur_betap /= Bta ^ 2

  cur_betap

end
