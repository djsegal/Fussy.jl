"""
    Vol_HTS()

Lorem ipsum dolor sit amet.
"""
function Vol_HTS()

  cur_Vol_HTS = WP_Area()

  cur_Vol_HTS *= Frac_HTS()

  cur_Vol_HTS *= magnet_num_coils

  cur_Vol_HTS *= Coil_P()

  cur_Vol_HTS

end
