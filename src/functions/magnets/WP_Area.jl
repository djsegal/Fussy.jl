"""
    WP_Area()

Determine Total Cable Cross Secional Area.
"""
function WP_Area()
  Cable_dim = Area_Cable()^0.5 # square dimension of cable cross section

  cur_WP_Area = (WP_d()*Cable_dim)*(WP_w()*Cable_dim) # total winding pack area

  cur_WP_Area
end
