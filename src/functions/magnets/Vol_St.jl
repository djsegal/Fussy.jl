"""
    Vol_St()

Lorem ipsum dolor sit amet.
"""
function Vol_St()

  cur_Vol_St = WP_Area()

  cur_Vol_St *= Frac_St()

  cur_Vol_St *= magnet_num_coils

  cur_Vol_St *= Coil_P()

  cur_Vol_St

end
