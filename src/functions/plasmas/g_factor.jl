"""
    g_factor(cur_delta=delta)

Lorem ipsum dolor sit amet.
"""
function g_factor(cur_delta=delta)
  if !enable_geom_factor
    return 1.0
  end

  cur_g_factor = 8.7

  cur_g_factor -= 2 * cur_delta

  cur_g_factor += 0.3 * cur_delta ^ 2

  cur_g_factor /= 8

  cur_g_factor
end
