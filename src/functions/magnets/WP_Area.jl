"""
    WP_Area(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

Determine Total Cable Cross Secional Area.
"""
function WP_Area(cur_R_0=R_0, cur_n_bar=n_bar, cur_I_M=I_M)

  # square dimension of cable cross section

  Cable_dim = Area_Cable(cur_R_0, cur_n_bar, cur_I_M) ^ 0.5

  # total winding pack area

  cur_WP_Area = WP_d() * Cable_dim

  cur_WP_Area *= WP_w() * Cable_dim

  cur_WP_Area

end
