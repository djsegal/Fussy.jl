"""
    wall_loading_limit()

Lorem ipsum dolor sit amet.
"""
function wall_loading_limit()
  cur_wall_loading = K_W()

  cur_wall_loading *= ( solved_steady_density() / 1u"n20" ) ^ 2

  cur_wall_loading *= ( R_0 / 1u"m" )

  cur_wall_loading *= ( sigma_v_hat / 1u"m^3/s" )

  cur_wall_loading -= ( P_W / ( 1u"MW" / 1u"m^2" ) )

  cur_wall_loading
end
