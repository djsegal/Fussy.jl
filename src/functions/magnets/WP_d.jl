@doc """
    WP_d()

Winding pack radial depth [m].
"""
@memoize function WP_d()

  cur_WP_d = magnet_Turns1()

  cur_WP_d /= WP_AR

  cur_WP_d ^= 0.5

  cur_WP_d = ceil(cur_WP_d)

  cur_WP_d

end
