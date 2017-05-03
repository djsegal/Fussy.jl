"""
    target_angle()

Lorem ipsum dolor sit amet.
"""
function target_angle()
  cur_angle = 0.48

  cur_angle *= kappa
  cur_angle -= delta
  cur_angle = 1 / cur_angle

  cur_angle *= 1.397
  cur_angle *= kappa
  cur_angle = atan(cur_angle)

  cur_angle
end
