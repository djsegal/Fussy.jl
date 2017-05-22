"""
    Vol_WP()

Lorem ipsum dolor sit amet.
"""
function Vol_WP()

  cur_Vol_WP = WP_Area()

  cur_Vol_WP *= Coil_P()

  cur_Vol_WP *= magnet_num_coils

  cur_Vol_WP

end
