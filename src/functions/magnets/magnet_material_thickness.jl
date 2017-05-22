"""
    magnet_material_thickness()

Lorem ipsum dolor sit amet.
"""
function magnet_material_thickness()

  cur_magnet_normalized_radius = magnet_normalized_radius()

  # Tensile Force

  cur_FT = pi
  cur_FT *= ( B_0 / 1u"T" )^2
  cur_FT *= ( R_0 / 1u"m" )^2
  cur_FT /= (2*standard_mu_0)
  cur_FT *= log(
    (1+cur_magnet_normalized_radius) /
    (1-cur_magnet_normalized_radius)
  )

  # Total Stress and Thickness

  cur_left_term = ( R_0 / 1u"m" )
  cur_left_term *= cur_FT
  cur_left_term /= pi
  cur_left_term /= ( R_0 / 1u"m" )^2
  cur_left_term /= 2 - 2 * cur_magnet_normalized_radius

  cur_right_term = magnet_centering_force()
  cur_right_term /= 2
  cur_right_term /= magnet_straight_factor
  cur_right_term /= kappa * ( a() / 1u"m" ) + ( blanket_thickness() / 1u"m" )

  cur_c = cur_left_term
  cur_c += cur_right_term
  cur_c /= magnet_Sy

  cur_c

end
