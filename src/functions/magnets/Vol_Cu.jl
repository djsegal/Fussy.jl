"""
    Vol_Cu()

Lorem ipsum dolor sit amet.
"""
function Vol_Cu()

  cur_Vol_Cu = WP_Area()

  cur_Vol_Cu *= Frac_Cu()

  cur_Vol_Cu *= magnet_num_coils

  cur_Vol_Cu *= Coil_P()

  cur_Vol_Cu

end
