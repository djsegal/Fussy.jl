"""
    WP_Area()

Determine Total Cable Cross Secional Area.
"""
function WP_Area()

  # square dimension of cable cross section

  Cable_dim = Area_Cable() ^ 0.5

  # total winding pack area

  cur_WP_Area = WP_d() * Cable_dim

  cur_WP_Area *= WP_w() * Cable_dim

  cur_WP_Area

end
