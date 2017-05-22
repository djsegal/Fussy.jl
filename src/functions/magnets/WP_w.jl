"""
    WP_w()

Widing pack toroidal width [m].
"""
function WP_w()

  cur_WP_w = magnet_Turns1()

  cur_WP_w /= WP_d()

  cur_WP_w = ceil(cur_WP_w)

  cur_WP_w

end
