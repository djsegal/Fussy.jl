"""
    Vol_WP(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Lorem ipsum dolor sit amet.
"""
function Vol_WP(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  cur_Vol_WP = WP_Area(cur_R_0, cur_n_bar, cur_I_M)

  cur_Vol_WP *= Coil_P(cur_R_0, cur_n_bar, cur_I_M)

  cur_Vol_WP *= magnet_num_coils

  cur_Vol_WP

end
