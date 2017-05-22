"""
    Vol_H2()

Lorem ipsum dolor sit amet.
"""
function Vol_H2()

  cur_Vol_H2 = WP_Area()

  cur_Vol_H2 *= Frac_H2()

  cur_Vol_H2 *= magnet_num_coils

  cur_Vol_H2 *= Coil_P()

  cur_Vol_H2

end
