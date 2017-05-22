"""
    V_TF()

Volume of TF Coil Structure not including HTS.
"""
function V_TF()

  cur_magnet_material_thickness = magnet_material_thickness()

  cur_reduced_radius = R_0

  cur_reduced_radius -= a()

  cur_reduced_radius -= blanket_thickness()

  cur_reduced_radius -= ( cur_magnet_material_thickness * 1u"m" ) / 2

  cur_reduced_radius /= 1u"m"

  cur_V_TF = magnet_num_coils

  cur_V_TF *= cur_magnet_material_thickness

  cur_V_TF *= ( 2 * pi / magnet_num_coils )

  cur_V_TF *= cur_reduced_radius

  cur_V_TF *= ( 2 * magnet_L1() + 2 * magnet_L2() )

  cur_V_TF

end
