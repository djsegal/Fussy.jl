"""
    wall_loading_limit()

Lorem ipsum dolor sit amet.
"""
function wall_loading_limit()
  cur_wall_loading = P_n()

  cur_wall_loading /= S_W()

  cur_wall_loading -= P_W

  cur_wall_loading
end
