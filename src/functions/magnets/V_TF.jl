"""
    V_TF()

Volume of TF Coil Structure not including HTS.
"""
function V_TF()
  magnet_num_coils*magnet_material_thickness()*(2*pi/magnet_num_coils)*(( R_0 / 1u"m" ) - ( a() / 1u"m" ) - ( blanket_thickness() / 1u"m" ) - magnet_material_thickness()/2)*(2*magnet_L1() + 2*magnet_L2())  # Volume of TF coil
end
